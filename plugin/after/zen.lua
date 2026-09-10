-- zen_mode.lua
-- Vanilla Neovim zen mode — no plugins required (Neovim 0.8+)
--
-- Toggle:  <leader>z  (normal mode)

local M = {}

local _state = {}
local _active = false

-- Window-local options (saved/restored per-window via vim.wo)
local WIN_OPTS = {
  'number',
  'relativenumber',
  'signcolumn',
  'foldcolumn',
  'cursorline',
  'colorcolumn',
  'statusline',
}

-- Global options (saved/restored via vim.o)
local GLOBAL_OPTS = {
  -- 'laststatus',
  'showmode',
  'ruler',
  'showcmd',
  -- 'cmdheight',
  'showtabline',
}

local function save_state()
  _state = {}
  for _, k in ipairs(GLOBAL_OPTS) do
    _state[k] = vim.o[k]
  end
  for _, k in ipairs(WIN_OPTS) do
    _state[k] = vim.wo[k]
  end
end

local function restore_state()
  for _, k in ipairs(GLOBAL_OPTS) do
    vim.o[k] = _state[k]
  end
  for _, k in ipairs(WIN_OPTS) do
    vim.wo[k] = _state[k]
  end
end

-- Create a transparent padding window on the given side
local function make_pad_win(side, width)
  vim.cmd(side == 'left' and 'leftabove vsplit' or 'rightbelow vsplit')
  vim.cmd 'enew'
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].buflisted = false
  vim.bo[buf].swapfile = false

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'
  vim.wo[win].foldcolumn = '0'
  vim.wo[win].cursorline = false
  vim.wo[win].colorcolumn = ''
  vim.wo[win].statusline = ' '
  vim.wo[win].winfixwidth = true

  vim.api.nvim_win_set_width(win, width)
  return win
end

function M.enter()
  if _active then
    return
  end -- guard: no double-enter / state corruption

  save_state()

  -- Strip all UI chrome (global options)
  -- vim.o.laststatus = 0
  vim.o.showmode = false
  vim.o.ruler = false
  vim.o.showcmd = false
  vim.o.cmdheight = 0
  vim.o.showtabline = 0

  -- Strip UI chrome (window-local options)
  vim.wo.number = false
  vim.wo.relativenumber = false
  vim.wo.signcolumn = 'no'
  vim.wo.foldcolumn = '0'
  vim.wo.cursorline = false
  vim.wo.colorcolumn = ''
  vim.wo.statusline = '%f'

  -- Close every other split; keep only the writing window
  vim.cmd 'only'

  -- Center the buffer with blank padding windows (target width = 80)
  local pad = math.floor((vim.o.columns - 80) / 2)
  if pad > 0 then
    local center_win = vim.api.nvim_get_current_win()
    make_pad_win('left', pad)
    vim.api.nvim_set_current_win(center_win)
    make_pad_win('right', pad)
    vim.api.nvim_set_current_win(center_win)
  end

  -- Soft-wrap for comfortable prose writing
  vim.wo.wrap = true
  vim.wo.linebreak = true
  vim.wo.breakindent = true

  _active = true
  vim.notify('Zen mode ON', vim.log.levels.INFO)
end

function M.exit()
  if not _active then
    return
  end -- guard: no exit before enter

  -- Close padding windows; keep only the writing window
  vim.cmd 'only'

  restore_state()

  -- Reset prose-wrap (not tracked in _state, reset to nvim defaults)
  vim.wo.wrap = false
  vim.wo.linebreak = false
  vim.wo.breakindent = false

  _active = false
  vim.notify('Zen mode OFF', vim.log.levels.INFO)
end

function M.toggle()
  if _active then
    M.exit()
  else
    M.enter()
  end
end

function M.is_active()
  return _active
end

-- <leader>z to toggle
vim.keymap.set('n', '<leader>z', M.toggle, { desc = 'Toggle Zen mode' })

-- Re-center automatically when the terminal is resized
vim.api.nvim_create_autocmd('VimResized', {
  callback = function()
    if _active then
      M.exit()
      M.enter()
    end
  end,
})

return M
