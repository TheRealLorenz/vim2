vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
}

local neogit = require 'neogit'

neogit.setup()

vim.keymap.set('n', '<leader>g', function()
  neogit.open()
end, { desc = 'Open Neogit' })
