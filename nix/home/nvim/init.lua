require("nordinvandijk.keymap")
require("nordinvandijk.diagnostics")
require("nordinvandijk.plugins")
require("nordinvandijk.lsp")

vim.o.termguicolors = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.undofile = true
