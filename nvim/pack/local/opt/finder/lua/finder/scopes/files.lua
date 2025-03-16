local fzf = require("finder.fzf")
local quicklist = require("finder.quicklist")

local module = {}

local function destruct(line)
  local components = vim.fn.matchlist(line, '\\(.\\{-}\\)\\s*:\\s*\\(\\d\\+\\)\\s*:\\s*\\(.*\\)')
  local filename = vim.fn.fnameescape(components[2])
  local lnum = components[3]
  local text = components[4]

  return {
    filename = filename,
    lnum = lnum,
    text = text
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
  return function(lines)
    local item = destruct(lines[1])
    vim.cmd(cmd .. " " .. item.filename)
    vim.cmd(item.lnum)
    vim.cmd "normal! ^zz"

    if #lines > 1 then
      local ql = {}
      for _, line in ipairs(lines) do
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
    -- .. "    --bind 'ctrl-f:change-prompt(file> )+clear-query+reload(ag --nogroup \"^(?=.)\" {+})'"
local cmd = 'ag --nogroup "^(?=.)"'
    .. " | fzf"
    .. "    --prompt 'search> '"
    .. "    --multi"
    -- Match only the search result. ag outputs <path>:line:<searchresult>
    .. "    --delimiter=':'"
    .. "    --nth='3..'"
for key, _ in pairs(expects) do
  cmd = cmd .. " --expect=" .. key
end
print(cmd)

module.find = function()
  fzf.exec(cmd, function(paths)
    if #paths < 2 then
      return
    end

    (expects[table.remove(paths, 1)] or default)(paths)
  end)
end

return module
