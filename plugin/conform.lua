vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}

local conform = require 'conform'

conform.setup {
  formatters_by_ft = {
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    lua = { 'stylua' },
    python = { 'black' },
    javascript = { 'prettierd' },
    typescript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    css = { 'prettierd' },
    rust = { 'rustfmt' },
    json = { 'prettierd' },
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
