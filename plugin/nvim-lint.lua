vim.pack.add {
  'https://github.com/mfussenegger/nvim-lint',
}

local lint = require 'lint'

---Returns a string with the configured linters
---for filetype.
---@param ft string? Filetype, nil for current buffer
---@return string
local function lint_info(ft)
  ft = ft or vim.bo.filetype
  local linters = lint._resolve_linter_by_ft(ft)

  if #linters == 0 then
    return 'No configured linters for \'' .. ft .. '\''
  end

  return 'Configured linters for \''
    .. ft
    .. '\': '
    .. table.concat(linters, ', ')
end

vim.api.nvim_create_user_command('LintInfo', function(ctx)
  vim.print(lint_info(ctx.fargs[1]))
end, { nargs = '?' })

lint.linters_by_ft = {
  python = { 'flake8' },
  json = { 'jsonlint' },
}
table.insert(lint.linters.cppcheck.args, '--suppress=missingIncludeSystem')

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  callback = function()
    lint.try_lint()
  end,
})
