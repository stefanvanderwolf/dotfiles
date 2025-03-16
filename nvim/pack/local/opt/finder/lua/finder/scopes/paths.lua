local fzf = require("finder.fzf")
local quicklist = require("finder.quicklist")

local module = {}

local function destruct(line)
  local filename = vim.fn.fnameescape(line)

  return {
    filename = filename,
  }
end

--- Create a fzf completion through a vim command
---
--- If more than one result is found the rest of the paths are put into the
--- quicklist.
---
--- @example calling this with `command("e")` makes fzf open the found file
--- with `:e`.
---
--- @param cmd string
--- @return fun(paths: string[])
local function command(cmd)
  return function(paths)
    vim.cmd(string.format("%s %s", cmd, paths[1]))

    if #paths > 1 then
      local ql = {}
      for _, line in ipairs(paths) do
        table.insert(ql, destruct(line))
      end
      quicklist.set(ql)
    end
  end
end

local default = command("e")
local expects = {
  ["return"] = default,
  ["ctrl-v"] = command("vsplit"),
  ["ctrl-x"] = command("split"),
}

    -- .. "    --bind 'ctrl-d:change-prompt(dir> )+reload(find . -type d)+print(dir)'"
    -- .. "    --bind 'ctrl-f:change-prompt(file> )+clear-query+reload(ag -g \".*\" --hidden {+})'"
local cmd = "ag -g '.*' --hidden"
    .. " | fzf"
    .. "    --prompt 'file> '"
    .. "    --multi"
for key, _ in pairs(expects) do
  cmd = cmd .. " --expect=" .. key
end

module.find = function()
  fzf.exec(cmd, function(paths)
    print(vim.inspect(paths))
    if #paths < 2 then
      return
    end

    (expects[table.remove(paths, 1)] or default)(paths)
  end)
end

return module
