local capabilities = require("cmp_nvim_lsp").default_capabilities()
return {
          capabilities = capabilities,
          on_attach = function()
            print("This will run when the server attaches!")
          end,
          filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
}
