--[[
Installation:
Run:

```sh
  brew install lua-language-server
```

Url: https://github.com/luals/lua-language-server
]]--

return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    }
  }
}
