return {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function ()
    require("tokyonight").setup()
    vim.cmd([[colorscheme tokyonight-night]])
  end
}
