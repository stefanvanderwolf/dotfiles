--[[
Installation:
Run:

```sh
  npm install -g typescript typescript-language-server
```

Url: https://github.com/typescript-language-server/typescript-language-server 
]] --

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "typescript" },
  root_markers = {
    "tsconfig.json",
    "package.json",
  },
}
