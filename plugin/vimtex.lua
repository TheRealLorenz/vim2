vim.pack.add { 'https://github.com/lervag/vimtex' }

vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_activate = 1
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk = {
  continuous = 1,
  options = {
    '-pdf',
    '-shell-escape',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}
-- vim.g.vimtex_quickfix_mode = 0 -- don't steal focus on warnings
-- vim.g.vimtex_quickfix_open_on_warning = 0
