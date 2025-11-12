local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
              },
            }
          }
}
