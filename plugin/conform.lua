vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}

local conform = require 'conform'

conform.setup {
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    css = { 'prettierd' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json = { 'prettierd' },
    latex = { 'latexindent' },
    lua = { 'stylua' },
    python = { 'black' },
    rust = { 'rustfmt' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
  },
}

vim.g.format_on_save = true

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(args)
    if vim.g.format_on_save then
      require('conform').format { bufnr = args.buf }
    end
  end,
})

vim.keymap.set('n', '<leader>tf', function()
  vim.g.format_on_save = vim.g.format_on_save or false
  vim.g.format_on_save = not vim.g.format_on_save
  vim.notify('Format on Save: ' .. tostring(vim.g.format_on_save))
end, { desc = 'Format on Save' })
