local fzf = require("finder.fzf")

local module = {}

local function find()
  -- Use empty string to avoid filter on the pattern.
  local pattern = ""

  -- Use the completion result from `getcompletion` to get all the available
  -- colorschemes.
  return vim.fn.getcompletion(pattern, "color")
end

local function command(cmd)
  return function(lines)
    vim.cmd(cmd .. " " .. lines[1])
  end
end

local default = command("colo")
local expects = {
  ["return"] = default,
}
local colorschemes = find()
local cmd = 'echo "' .. table.concat(colorschemes, "\n") .. '"'
    .. " | fzf"
    .. "    --prompt 'colo> '"
for key, _ in pairs(expects) do
  cmd = cmd .. " --expect=" .. key
end

module.find = function()
  fzf.exec(cmd, function(paths)
    if #paths < 2 then
      return
    end

    (expects[table.remove(paths, 1)] or default)(paths)
  end)
end

return module
