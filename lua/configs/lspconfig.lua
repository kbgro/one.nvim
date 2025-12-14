local M = {}

vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", { desc = "[L]sp [F]ormat" })

M.on_attach = function(event)
    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

  map("gD", vim.lsp.buf.declaration, "Go to declaration")
  map("gd", vim.lsp.buf.definition, "Go to definition")
  map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  map("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder", {'n'})
  map("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder", {'n'})
  map("<leader>wl", function()print(vim.inspect(vim.lsp.buf.list_workspace_folders()))end, "List workspace folders", {'n'})
  map("<leader>D", vim.lsp.buf.type_definition, "Go to type definition", {'n'})
end

M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

M.defaults = function()
  -- Attach keymaps when LSP attaches
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
      M.on_attach(event)
    end,
  })

  -- Custom settings for lua_ls
  local lua_lsp_settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  }

  -- Load mason-lspconfig safely
  local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not ok then
    vim.notify("mason-lspconfig not loaded", vim.log.levels.ERROR)
    return
  end

  -- Setup Mason with automatic installation of servers
  mason_lspconfig.setup({
    automatic_installation = true,
  })

  -- Get all servers installed via Mason
  local installed_servers = mason_lspconfig.get_installed_servers()

  for _, server_name in ipairs(installed_servers) do
    local opts = {
      capabilities = M.capabilities,
      on_attach = M.on_attach,
      on_init = M.on_init,
      settings = {},
    }

    -- Apply custom settings for lua_ls
    if server_name == "lua_ls" then
      opts.settings = lua_lsp_settings
    end

    -- Enable the server
    vim.lsp.enable(server_name, opts)
  end
end

return M
