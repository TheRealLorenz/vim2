local function plugin_names(arglead, used)
  return vim
    .iter(vim.pack.get(nil))
    :map(function(p)
      return p.spec.name
    end)
    :filter(function(name)
      return vim.startswith(name, arglead) and not vim.list_contains(used, name)
    end)
    :totable()
end

-- nil means "all plugins" for the vim.pack functions
local function or_nil(args)
  return #args > 0 and args or nil
end

local subcommands = {
  list = {
    run = function()
      vim.pack.update(nil, { offline = true })
    end,
  },
  install = {
    run = function(args)
      vim.pack.add(args)
    end,
  },
  update = {
    run = function(args)
      vim.pack.update(or_nil(args))
    end,
    complete = plugin_names,
  },
  info = {
    run = function(args)
      vim.notify(vim.inspect(vim.pack.get(or_nil(args))))
    end,
    complete = plugin_names,
  },
  delete = {
    run = function(args)
      vim.pack.del(args)
    end,
    complete = plugin_names,
  },
}

local sorted_names = vim.tbl_keys(subcommands)
table.sort(sorted_names)

vim.api.nvim_create_user_command('Pack', function(opts)
  local name = table.remove(opts.fargs, 1)
  local sub = subcommands[name]
  if not sub then
    vim.notify('Pack: invalid subcommand: ' .. name, vim.log.levels.ERROR)
    return
  end
  sub.run(opts.fargs)
end, {
  nargs = '+',
  desc = 'Manage `vim.pack`',
  complete = function(arglead, cmd_line)
    -- words = { 'Pack', <sub>, <done args...>, <arg_lead> }
    local words = vim.split(cmd_line, '%s+', { plain = false })

    if #words <= 2 then
      return vim.tbl_filter(function(n)
        return vim.startswith(n, arglead)
      end, sorted_names)
    end

    local sub = subcommands[words[2]]
    if not (sub and sub.complete) then
      return {}
    end

    return sub.complete(arglead, vim.list_slice(words, 3, #words - 1))
  end,
})
