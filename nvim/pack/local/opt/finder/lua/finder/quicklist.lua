local module = {}

module.set = function(paths)
  -- local qlist = {}
  -- for _, path in ipairs(paths) do
  --   table.insert(qlist, {
  --     filename = vim.fn.fnameescape(path)
  --   })
  -- end

  vim.fn.setqflist(paths)
end

return module
