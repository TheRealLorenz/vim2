local M = {}

local terminal = {
  win = nil,
  buf = nil,
}

M.toggle = function()
  if terminal.buf and not vim.api.nvim_buf_is_valid(terminal.buf) then
    terminal.buf = nil
  end

  if terminal.win and not vim.api.nvim_win_is_valid(terminal.win) then
    terminal.win = nil
  end

  if terminal.win then
    vim.api.nvim_win_hide(terminal.win)
    terminal.win = nil
    return
  end

  if not terminal.buf then
    terminal.buf = vim.api.nvim_create_buf(false, true)
  end

  terminal.win = vim.api.nvim_open_win(terminal.buf, true, {
    split = 'below',
    height = 10,
    style = 'minimal',
  })

  if vim.bo[terminal.buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
    terminal.buf = vim.api.nvim_get_current_buf()
    vim.wo[terminal.win].winfixbuf = true
    vim.bo[terminal.buf].buflisted = false
  end

  vim.cmd.startinsert()
end

vim.keymap.set('n', '<space>tt', M.toggle, { desc = 'Terminal' })
vim.keymap.set(
  't',
  '<Esc><Esc>',
  '<C-\\><C-n>',
  { desc = 'Exit terminal mode' }
)
