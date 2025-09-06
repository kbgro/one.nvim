
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("k-hightlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- [[ resize splits if window got resized ]]
local resize_group = vim.api.nvim_create_augroup('ResizeSplit', { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = resize_group,
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})
