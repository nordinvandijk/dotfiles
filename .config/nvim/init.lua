require("nordinvandijk.plugins")
require("nordinvandijk.plugin_config")

vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true }) -- Disable paste on middle mouse click
vim.cmd("set number") -- Line numbers
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
