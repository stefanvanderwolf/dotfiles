--[[
Installation:
Run:

```sh
  npm install --global vscode-langservers-extracted
```

Url: https://github.com/hrsh7th/vscode-langservers-extracted
]] --

return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = {
    "json",
    -- The jsonc is an extension of json which allows comments.
    "jsonc",
  },
  settings = {
    json = {
      schemas = {
        {
          description = "NPM configuration file",
          fileMatch = {
            "package.json",
          },
          url = "https://json.schemastore.org/package.json",
        },
        {
          description = "TypeScript compiler configuration file",
          fileMatch = {
            "tsconfig.json",
            "tsconfig.*.json",
          },
          url = "https://json.schemastore.org/tsconfig.json",
        },
      }
    }
  }
}
