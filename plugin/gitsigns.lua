vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
}

local gitsigns = require 'gitsigns'

gitsigns.setup()

vim.keymap.set('n', ']h', function()
  gitsigns.nav_hunk('next', {})
end, { desc = 'Next hunk' })

vim.keymap.set('n', '[h', function()
  gitsigns.nav_hunk('prev', {})
end, { desc = 'Next hunk' })
