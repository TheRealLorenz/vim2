vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
}

-- mini.ai
require('mini.ai').setup { n_lines = 500 }

-- mini.bufremove
local bufremove = require 'mini.bufremove'

bufremove.setup()

vim.keymap.set('n', '<leader>bd', bufremove.delete, { desc = 'Delete' })
local miniclue = require 'mini.clue'

-- mini.clue
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = '\'' },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = '\'' },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
}

-- mini.extra
require('mini.extra').setup()

-- mini.files
local files = require 'mini.files'

files.setup()

vim.keymap.set('n', '<leader>e', files.open, { desc = 'Open Explorer' })

-- mini.hipatterns
local hi_words = require('mini.extra').gen_highlighter.words

require('mini.hipatterns').setup {
  highlighters = {
    fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
    xxx = hi_words({ 'XXX' }, 'MiniHipatternsFixme'),
    hack = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
    todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
    note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),
  },
}

-- mini.icons
local icons = require 'mini.icons'

icons.setup()
icons.tweak_lsp_kind()

-- mini.notify
local notify = require 'mini.notify'

notify.setup {
  lsp_progress = { enable = false },
}

vim.notify = notify.make_notify()

-- mini.pairs
local pairs = require 'mini.pairs'

pairs.setup()

-- mini.pick
local picker = require 'mini.pick'

local extra = require 'mini.extra'

picker.setup()

vim.ui.select = picker.ui_select

vim.keymap.set('n', '<leader>f', picker.builtin.files, { desc = 'Pick Files' })
vim.keymap.set(
  'n',
  '<leader>/',
  picker.builtin.grep_live,
  { desc = 'Live Grep' }
)
vim.keymap.set('n', '<leader>bp', picker.builtin.buffers, { desc = 'Pick' })
vim.keymap.set('n', '<leader>?', extra.pickers.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>h', picker.builtin.help, { desc = 'Help' })

-- mini.surround
require('mini.surround').setup()

-- mini.tabline
require('mini.tabline').setup()
