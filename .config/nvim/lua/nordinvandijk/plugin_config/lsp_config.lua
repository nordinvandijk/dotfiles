require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
    "lua_ls", -- Lua
    "rust_analyzer", -- Rust
    "tsserver", -- Typescript
    "eslint",
    "tailwindcss",
    "marksman",
    "hls", -- Haskell
    "omnisharp" -- C#
  }
})

-- After setting up mason-lspconfig you may set up servers via lspconfig
local lspconfig = require('lspconfig')
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

lspconfig.rust_analyzer.setup {capabilities = capabilities}
lspconfig.tsserver.setup {capabilities = capabilities}
lspconfig.eslint.setup {capabilities = capabilities}
lspconfig.tailwindcss.setup {capabilities = capabilities}
lspconfig.marksman.setup {capabilities = capabilities}
lspconfig.hls.setup {capabilities = capabilities,}
lspconfig.omnisharp.setup {
  capabilities = capabilities,
  enable_roslyn_analysers = true,
	enable_import_completion = true,
	organize_imports_on_format = true,
	enable_decompilation_support = true,
	filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' }

}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts) 
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.diagnostic.config({
  virtual_text = false, -- Schakel inline diagnostics uit
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
