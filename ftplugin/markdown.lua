vim.pack.add {
  'https://github.com/iamcco/markdown-preview.nvim',
}

local plugin_info = vim.pack.get({ 'markdown-preview.nvim' })[1]

if plugin_info == nil then
  vim.notify 'markdown-preview.nvim is not installed'
  return
end

if vim.fn.isdirectory(plugin_info.path .. '/app/node_modules') == 0 then
  vim.fn['mkdp#util#install']()
end
