return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- Load conform before a buffer is written
  cmd = { "ConformInfo" },   -- Allow direct execution of ConformInfo
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ async = true, lsp_format = "only" })
      end,
      mode = "", -- apply in all modes
      desc = "Format buffer (LSP only)",
    },
  },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = "stylua",
        javascript = "prettier",
        typescript = "prettier",
        json = "prettier",
        html = "prettier",
        css = "prettier",
        scss = "prettier",
        less = "prettier",
        markdown = "prettier",
        yaml = "prettier",
          python = "black",
      },
    })
  end,
}
