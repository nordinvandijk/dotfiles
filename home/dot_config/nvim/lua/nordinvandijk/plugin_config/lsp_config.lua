return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls", -- Lua
        "rust_analyzer", -- Rust
        "ts_ls", -- Typescript
        "eslint", -- ESLint
        "tailwindcss", -- TailwindCSS
        "marksman", -- Markdown
        "omnisharp" -- C#
      }
    },
    dependencies = {
        { 
          "mason-org/mason.nvim", 
          opts = {
            registries = {
              "github:mason-org/mason-registry",
              "github:Crashdummyy/mason-registry"
            }
          } 
        },
        "neovim/nvim-lspconfig",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.lua_ls.setup {
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
        
        lspconfig.roslyn.setup { 
          capabilities = capabilities,
          on_attach = function()
            print("This will run when the server attaches!")
          end,
          filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }
        }
        lspconfig.rust_analyzer.setup {capabilities = capabilities}
        lspconfig.ts_ls.setup {capabilities = capabilities}
        lspconfig.eslint.setup {capabilities = capabilities}
        lspconfig.tailwindcss.setup {capabilities = capabilities}
        lspconfig.marksman.setup {capabilities = capabilities}
        lspconfig.gh_actions_ls.setup { capabilities = capabilities }

        vim.api.nvim_create_autocmd('LspAttach', {
          group = vim.api.nvim_create_augroup('UserLspConfig', {}),
          callback = function(ev)
            -- Enable completion triggered by <c-x><c-o>
            vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
            local builtin = require("telescope.builtin")
            -- Buffer local mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', builtin.lsp_definitions, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", builtin.lsp_references, opts)
            vim.keymap.set('n', '<space>f', function()
              vim.lsp.buf.format { async = true }
            end, opts)
          end,
        })

        vim.diagnostic.config({
          virtual_text = false, -- Disable inline diagnostics uit
        })

        -- Toon alle diagnostics op de huidige regel in een zwevend venster
        vim.api.nvim_set_keymap(
          'n', '<space>d', ':lua vim.diagnostic.open_float()<CR>',
          { noremap = true, silent = true }
        )

        -- Ga naar de volgende diagnostic (als er meerdere op dezelfde regel zijn, wordt er
        -- slechts één tegelijk in het zwevende venster getoond)
        vim.api.nvim_set_keymap(
          'n', '<Leader>n', ':lua vim.diagnostic.goto_next()<CR>',
          { noremap = true, silent = true }
        )

        -- Ga naar de vorige diagnostic (als er meerdere op dezelfde regel zijn, wordt er
        -- slechts één tegelijk in het zwevende venster getoond)
        vim.api.nvim_set_keymap(
          'n', '<Leader>p', ':lua vim.diagnostic.goto_prev()<CR>',
          { noremap = true, silent = true }
        )
    end
}
