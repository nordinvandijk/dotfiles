require("nordinvandijk.plugins")

vim.o.termguicolors = true
vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true }) -- Disable paste on middle mouse click
vim.cmd("set number") -- Line numbers
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.clipboard = "unnamedplus"
