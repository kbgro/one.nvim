-- Modes --
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Normal --
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
vim.keymap.set("n", "<S-l>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
vim.keymap.set("n", "<S-q>", "<cmd>bdelete!<CR>", opts)

-- Better paste
vim.keymap.set("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
vim.keymap.set("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
vim.keymap.set("n", "<leader>e", ":Neotree<CR>", opts)

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })

-- Git
vim.keymap.set("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
vim.keymap.set("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
vim.keymap.set("x", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)

-- DAP
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
vim.keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
