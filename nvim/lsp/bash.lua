--[[
Installation:
Run:

```sh
  npm install --global bash-language-server
```

The language server will automatically pickup:
* shellcheck: linting
* shlfmt: formatting

```sh
brew install shellcheck
brew install shfmt
```

Url: https://github.com/bash-lsp/bash-language-server
]] --

return {
  cmd = { "bash-language-server", "start" },
  filetypes = {
    "bash",
    "sh",
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
