-- Disable Hightlight Search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set({ 'x', 'n' }, 'j', 'gj', { noremap = true, silent = true })
vim.keymap.set({ 'x', 'n' }, 'k', 'gk', { noremap = true, silent = true })
