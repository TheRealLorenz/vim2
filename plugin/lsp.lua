vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
}

local trigger_chars = {}
for i = 32, 126 do
  table.insert(trigger_chars, string.char(i))
end

---@param client vim.lsp.Client
---@param buf integer
local setup_completion = function(client, buf)
  -- local highlights = require 'user.highlights'
  local kind_hlgroup = {
    nil, ---Text
    '@lsp.type.method', ---Method
    '@lsp.type.function', ---Function
    '@constructor', ---Constructor
    '@field', ---Field
    '@variable', ---Variable
    '@lsp.type.class', ---Class
    '@lsp.type.interface', ---Interface
    '@module', ---Module
    '@property', --- Property
    nil, --- Unit
    nil, --- Value
    '@lsp.type.enum', --- Enum
    nil, --- Keyword
    nil, --- Snippet
    nil, --- Color
    nil, --- File
    nil, --- Reference
    nil, --- Folder
    nil, --- EnumMember
    nil, --- Constant
    nil, --- Struct
    nil, --- Event
    nil, --- Operator
    nil, --- TypeParameter
  }

  client.server_capabilities.completionProvider.triggerCharacters =
    trigger_chars

  vim.lsp.completion.enable(true, client.id, buf, {
    autotrigger = true,
    convert = function(item)
      return { kind_hlgroup = kind_hlgroup[item.kind] }
    end,
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    local lsp_map = function(keys, func, desc)
      vim.keymap.set(
        'n',
        keys,
        func,
        { buffer = args.buf, desc = 'LSP: ' .. desc }
      )
    end

    lsp_map('gd', function()
      require('mini.extra').pickers.lsp { scope = 'definition' }
    end, 'Goto Definition')
    lsp_map('gD', function()
      require('mini.extra').pickers.lsp { scope = 'declaration' }
    end, 'Goto Declaration')

    -- Toggle Inlay Hints
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable()
      lsp_map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(nil))
      end, 'Inlay Hints')
    end

    -- Highlight symbol under cursor
    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client.server_capabilities.completionProvider then
      setup_completion(client, args.buf)
    end
  end,
})

vim.lsp.config('clangd', {
  cmd = { 'clangd', '--query-driver=**' },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

vim.lsp.enable {
  'lua_ls',
  'clangd',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'tinymist',
  'emmet_language_server',
  'cssls',
  'html',
  'tailwindcss',
  'angularls',
  'gopls',
  'eslint',
  'svelte',
}
