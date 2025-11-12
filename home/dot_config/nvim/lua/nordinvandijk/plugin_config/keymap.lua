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
