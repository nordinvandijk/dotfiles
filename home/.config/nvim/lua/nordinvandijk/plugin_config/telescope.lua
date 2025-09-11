return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function ()
      local telescope = require('telescope')
      telescope.setup({
        file_ignore_patterns = { "node%_modules/.*", "node_modules", "^node_modules/*", "node_modules/*" },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })

      pcall(require("telescope").load_extension, "ui-select")

      -- Builtin
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<c-p>', builtin.find_files, {})
      vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
      vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
      vim.keymap.set("n", "<space>en", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end)
    end
}
