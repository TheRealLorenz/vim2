local g = vim.g

g.mapleader = ' '
g.maplocalleader = ' '

local opt = vim.opt

opt.autoindent = true
opt.breakindent = true
opt.clipboard = 'unnamedplus'
opt.completeopt = { 'noselect', 'fuzzy', 'menuone' }
opt.cursorline = true
opt.expandtab = true
opt.ignorecase = true -- Unless \C
opt.inccommand = 'split'
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.mouse = 'a'
opt.number = true
opt.scrolloff = 10
opt.shiftwidth = 4
opt.signcolumn = 'number'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 4
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.timeoutlen = 300
opt.undofile = true
opt.updatetime = 250
opt.winborder = 'rounded'

-- opt.number = true
-- opt.laststatus = 3

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  -- virtual_lines = true,
  -- virtual_text = true,
}
