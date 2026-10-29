vim.api.nvim_set_keymap('n', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true }) -- Disable paste on middle mouse click

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
