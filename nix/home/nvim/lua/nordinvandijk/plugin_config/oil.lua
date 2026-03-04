return  {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
     columns = {
    -- "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
    view_options = {
      show_hidden = true
    }
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

