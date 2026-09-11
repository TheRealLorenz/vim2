vim.pack.add { 'https://github.com/lervag/vimtex' }

if vim.fn.has 'macunix' == 1 then
  vim.g.vimtex_view_method = 'skim'
else
  vim.g.vimtex_view_method = 'zathura'
end

-- vim.g.vimtex_view_skim_sync = 1
-- vim.g.vimtex_view_skim_activate = 1

-- vim.g.vimtex_compiler_method = 'latexmk'
-- vim.g.vimtex_compiler_latexmk = {
--   continuous = 1,
--   options = {
--     '-pdf',
--     '-shell-escape',
--     '-verbose',
--     '-file-line-error',
--     '-synctex=1',
--     '-interaction=nonstopmode',
--     '-recorder',
--   },
-- }
