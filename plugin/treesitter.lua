vim.pack.add { 'https://github.com/nvim-treesitter/nvim-treesitter' }

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    -- silently skips filetypes with no parser
    local ok, _ = pcall(vim.treesitter.start, args.buf)
    if ok then
      -- folds
      -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo[0][0].foldmethod = 'expr'
      -- indent (experimental)
      vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
    end
  end,
})
