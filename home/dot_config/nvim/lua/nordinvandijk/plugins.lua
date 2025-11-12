-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },

      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

local dap = require("nordinvandijk.plugin_config.dap")
local neotest = require("nordinvandijk.plugin_config.neotest")
local treesitter = require("nordinvandijk.plugin_config.treesitter")
local theme = require("nordinvandijk.plugin_config.theme")
local telescope = require("nordinvandijk.plugin_config.telescope")
local autocomplete = require("nordinvandijk.plugin_config.autocomplete")
local formatter = require("nordinvandijk.plugin_config.formatter")
local gitsigns = require("nordinvandijk.plugin_config.gitsigns")
local lsp_config = require("nordinvandijk.plugin_config.lsp_config")
local oil = require("nordinvandijk.plugin_config.oil")
local keymaps = require("nordinvandijk.plugin_config.keymap")
local diagnostics = require("nordinvandijk.plugin_config.diagnostics")

local plugins = {
  {
    "seblyng/roslyn.nvim",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        -- your configuration comes here; leave empty for default settings
    },
  },
  theme,
  keymaps,
  diagnostics,
  lsp_config,
  treesitter,
  telescope,
  dap,
  neotest,
  autocomplete,
  formatter,
  gitsigns,
  oil,
}

local opts = {}

require("lazy").setup(plugins, opts)

