local illuminate = require "illuminate"
vim.g.Illuminate_ftblacklist = { "NvimTree" }
vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
vim.api.nvim_set_keymap(
  "n",
  "<a-p>",
  '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
  { noremap = true }
)

illuminate.configure {
  providers = {
    "lsp",
    "treesitter",
    "regex",
  },
  delay = 200,
  filetypes_denylist = {
    "fugitive",
    "NvimTree",
    "lazy",
    "neogitstatus",
    "spectre_panel",
    "toggleterm",
    "TelescopePrompt",
  },
  filetypes_allowlist = {},
  modes_denylist = {},
  modes_allowlist = {},
  providers_regex_syntax_denylist = {},
  providers_regex_syntax_allowlist = {},
  under_cursor = true,
}
