local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values

-- show notification
local function notify(msg, level)
    level = level or vim.log.levels.INFO
    require("notify")(msg, level, {
        title = "QT",
    })
end

M = {}


-- [[CMakeList]]

CMakeList = {
    filepath = vim.fn.findfile("CMakeLists.txt", ".;"),
    pattern = "set%(%s*CMAKE_EXPORT_COMPILE_COMMANDS%s+(%a+)%)",
    command = "set(CMAKE_EXPORT_COMPILE_COMMANDS %s)"
}

-- @param file tole close
function CMakeList.close(file)
    if file ~= nil then
        file.close()
    end
end

function CMakeList.open(mode)
    -- local filepath = vim.fn.findfile("CMakeLists.txt", ".;")
    if mode == nil or mode == "r" then
        local cmake_file = io.open(CMakeList.filepath, mode or "r")
        if cmake_file ~= nil then
            local temp_cmake_file = io.tmpfile()
            if temp_cmake_file ~= nil then
                local content = cmake_file:read("*a")
                temp_cmake_file:write(content)
                temp_cmake_file:seek("set", 0)
                cmake_file:close()
                return temp_cmake_file
            end
        end
    end

    return io.open(CMakeList.filepath, mode)
end

function CMakeList.Exists()
    return vim.fn.filereadable(CMakeList.filepath) == 1
end

function CMakeList.Update(new_lines)
    local file = CMakeList.open("w")
    if file ~= nil then
        for _, line in ipairs(new_lines) do
            file:write(line .. "\n")
        end
        CMakeList.close(file)
    end
end

function CMakeList.AddExportCommand()
    local modified_lines = {}
    local cmake_file = CMakeList.open("r")

    for line in cmake_file:lines() do
        if line:match("find_package%(%s*Qt6") then
            table.insert(modified_lines, CMakeList.command:format("ON"))
        end
        table.insert(modified_lines, line)
    end

    CMakeList.close(cmake_file)
    CMakeList.Update(modified_lines)
end

-- @return bool true false or nil
function CMakeList.ExportCommandStatus()
    local cmake_file = CMakeList.open("r")
    local command_status = nil

    for line in cmake_file:lines() do
        local status = line:match(CMakeList.pattern)
        if status then
            status = status:lower()
            if status == "no" or status == "off" or status == "0" then
                command_status = false
            elseif status == "yes" or status == "on" or status == "1" then
                command_status = true
            end
            break
        end
    end

    CMakeList.close(cmake_file)
    return command_status
end

-- Enable of disables export command
-- @param cmd_status bool the value to enable or disable export command
-- @return create bool export command pattern was not found if true
function CMakeList.UpdateExportCommand(cmd_status)
    local modified_lines = {}
    local cmake_file = CMakeList.open("r")
    local command_status = nil
    local modified = false
    local create = true

    for line in cmake_file:lines() do
        local status = line:match(CMakeList.pattern)
        if status then
            create = false
            status = status:lower()
            if status == "no" or status == "off" or status == "0" then
                command_status = false
            elseif status == "yes" or status == "on" or status == "1" then
                command_status = true
            end

            if command_status ~= nil and cmd_status ~= command_status then
                local cmd_txt = cmd_status and "ON" or "OFF"
                line = line:gsub(CMakeList.pattern, CMakeList.command:format(cmd_txt))
                modified = true
            end
        end
        table.insert(modified_lines, line)
    end

    CMakeList.close(cmake_file)
    if modified then
        CMakeList.Update(modified_lines)
    end

    return create
end

function CMakeList.RemoveExportCommand()
    local modified_lines = {}
    local modified = false

    local cmake_file = CMakeList.open("r")
    for line in cmake_file:lines() do
        local status = line:match(CMakeList.pattern)
        if status then
            modified = true
        else
            table.insert(modified_lines, line)
        end
    end
    CMakeList.close(cmake_file)
    if modified then
        CMakeList.Update(modified_lines)
    end

    return modified
end

function CMakeList.remove_cmake_compile_commands()
    if CMakeList.RemoveExportCommand() then
        notify(("CMAKE_EXPORT_COMPILE_COMMANDS: %s"):format("[REMOVED]"))
    end
end

function CMakeList.disable_cmake_compile_commands()
    if CMakeList.UpdateExportCommand(false) then
        notify(("CMAKE_EXPORT_COMPILE_COMMANDS: %s"):format("[OFF]"))
    end
end

function CMakeList.enable_cmake_compile_commands()
    local pattern_found = CMakeList.UpdateExportCommand(true)
    if pattern_found then
        CMakeList.AddExportCommand()
    end

    notify(("CMAKE_EXPORT_COMPILE_COMMANDS: %s"):format("[ON]"))
end

-- [[ QT ]]

Qt = {}


function Qt.build_compile_json_files()
    local profiles = vim.fn.glob("./build/*", true, false)
    local profile_list = {}
    if #profiles == 0 then
        M.notify("Create build profiles", vim.log.levels.ERROR);
    else
        profile_list = vim.split(profiles, "\n")
    end
    return profile_list
end

function Qt.copy_clang_compile_commands(source_path)
    local sep = package.config:sub(1, 1)
    local source_paths = vim.split(source_path, sep)
    local dest_path = source_paths[#source_paths]

    local source_file = io.open(source_path, "r")
    if source_file == nil then
        notify("Error opening source file: ", vim.log.levels.ERROR)
        return
    end

    local content = source_file:read("*a")
    source_file:close()

    local dest_file = io.open(dest_path, "w")
    if dest_file == nil then
        notify("Error opening destination file: ", vim.log.levels.ERROR)
        return
    end

    dest_file:write(content)
    dest_file:close()
end

function Qt.telescope_list_build_compile_json()
    local sep = package.config:sub(1, 1)
    local opts = require("telescope.themes").get_dropdown {}

    pickers.new(opts, {
        prompt_title = "compile commands",
        finder = finders.new_table {
            results = Qt.build_compile_json_files(),
            entry_maker = function(entry)
                local display_list = vim.split(entry, sep)
                return {
                    value = entry,
                    display = display_list[#display_list],
                    ordinal = entry,
                }
            end
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                Qt.copy_clang_compile_commands(selection.value .. sep .. "compile_commands.json")
                notify(("Updating compile commands: %s"):format(selection.display), vim.log.levels.INFO)
            end)
            return true
        end
    }):find()
end

function Qt.toggle_compile_commands()
    local ex_status = CMakeList.ExportCommandStatus()
    if ex_status == nil or ex_status == false then
        CMakeList.enable_cmake_compile_commands()
    else
        CMakeList.disable_cmake_compile_commands()
    end
end

function M.setup(opts)
    vim.keymap.set("n", "<leader>cf", Qt.telescope_list_build_compile_json, { desc = "Qt Compile commands" })
    vim.keymap.set("n", "<leader>te", Qt.toggle_compile_commands, { desc = "Qt Toggle set compile commands" })
end

function M.is_qt6_project()
    local qt_found = false

    if CMakeList.Exists() then
        local cmake_file = CMakeList.open("r")
        for line in cmake_file:lines() do
            if line:match("find_package%(%s*Qt6") then
                qt_found = true
                break
            end
        end
        CMakeList.close(cmake_file)
    end

    return qt_found
end

M.nofity = notify

return M
