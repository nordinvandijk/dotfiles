return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup {
        ensure_installed = { "c", "lua", "rust", "ruby", "vim", "html", "javascript" },
        highlight = {
          enable = true,
        },
      }
    end,
  },
}
