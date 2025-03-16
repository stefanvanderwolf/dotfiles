local math = require("finder.math")

local module = {}

--- @return number buffer_handle
local function create_buffer()
  local listed = false
  local scratch = true
  local buffer_handle = vim.api.nvim_create_buf(listed, scratch)

  return buffer_handle
end

local function open_window(buffer_handle)
  local preferred_height = 15
  local width = vim.api.nvim_get_option_value("columns", {})
  local height = vim.api.nvim_get_option_value("lines", {})
  local row = height - math.clamp(preferred_height, 1, height)

  local enter = true
  local options = {
    relative = "editor",
    width = width,
    height = preferred_height,
    row = row,
    col = 0,
    style = "minimal",
    border = { "", "─", "", "", "", "", "", "" },
  }
  local window_handle = vim.api.nvim_open_win(buffer_handle, enter, options)

  vim.cmd("startinsert")

  return window_handle
end

local function collect(buffer_handle)
    local line_start = 0
    local line_end = -1
    local strict_indexing = true

    local lines = vim.tbl_filter(function(line)
        return line ~= ''
    end, vim.api.nvim_buf_get_lines(buffer_handle, line_start, line_end, strict_indexing))

    return lines
end

module.exec = function(cmd, completion_handler)
  local buffer_handle = create_buffer()
  local window_handle = open_window(buffer_handle)

  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      local lines = collect(buffer_handle)

      vim.api.nvim_win_close(window_handle, true)

      if exit_code > 0 then
        return
      end

      completion_handler(lines)
    end,
  })
end

return module
