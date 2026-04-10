vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
  desc = 'Enter insert mode when moving into terminal',
  pattern = 'term://*',
  command = 'startinsert',
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Auto resize panes when resizing nvim window',
  pattern = '*',
  command = 'tabdo wincmd =',
})
