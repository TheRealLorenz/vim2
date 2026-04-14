vim.pack.add {
  'https://github.com/Darazaki/indent-o-matic',
}

require('indent-o-matic').setup {
  max_lines = 2048,
  standard_widths = { 2, 4, 8 },
}

vim.keymap.set('n', '<leader>i', function()
  vim.notify 'Reload indents'
  vim.cmd [[IndentOMatic]]
end, { desc = 'Detect Indent' })
