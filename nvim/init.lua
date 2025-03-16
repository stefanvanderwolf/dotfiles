-- Internal plugins
--
-- Pick and choose which internal plugin should be enabled. Setting loaded to
-- true will stop loading the plugin because the plugin thinks it is already
-- loaded. Some plugins are newer and use a different construct like
-- `editorconfig`.
vim.g.editorconfig = true
vim.g.loaded_gzip = true
vim.g.loaded_man = true
vim.g.loaded_matchit = false
vim.g.loaded_matchparen = false
vim.g.loaded_netrwPlugin = true
vim.g.loaded_remote_plugins = true
vim.g.loaded_shada_plugin = false
vim.g.loaded_spellfile_plugin = false
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true

vim.g.mapleader = " "

vim.opt.signcolumn = "yes"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.backup = false
vim.opt.laststatus = 2
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.lazyredraw = true
vim.opt.swapfile = false
vim.opt.shellcmdflag = "--login --interactive -c"

-- Quality of life
vim.keymap.set({ "i", "n" }, "<c-c>", "<esc>")
vim.keymap.set("n", "<c-c>", "<esc><cmd>nohlsearch<cr>", { noremap = true })
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Quick list
local function is_quickfix_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "quickfix" then
      return true
    end
  end

  return false
end

vim.keymap.set('n', '~q', function()
  if is_quickfix_open() then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end)
vim.keymap.set('n', '!q', "<cmd>chistory<cr>")
vim.keymap.set('n', '<q', "<cmd>colder<cr>")
vim.keymap.set('n', '>q', "<cmd>cnewer<cr>")
vim.keymap.set('n', '[q', "<cmd>cprevious<cr>")
vim.keymap.set('n', ']q', "<cmd>cnext<cr>")
vim.keymap.set('n', '[Q', "<cmd>cfirst<cr>")
vim.keymap.set('n', ']Q', "<cmd>clast<cr>")

-- Location list
vim.keymap.set('n', '~l', function()
  if is_quickfix_open() then
    vim.cmd("lclose")
  else
    vim.cmd("lopen")
  end
end)
vim.keymap.set('n', '!q', "<cmd>lhistory<cr>")
vim.keymap.set('n', '<l', "<cmd>lolder<cr>")
vim.keymap.set('n', '>l', "<cmd>lnewer<cr>")
vim.keymap.set('n', '[l', "<cmd>lprevious<cr>")
vim.keymap.set('n', ']l', "<cmd>lnext<cr>")
vim.keymap.set('n', '[L', "<cmd>lfirst<cr>")
vim.keymap.set('n', ']L', "<cmd>llast<cr>")

-- Buffer
vim.keymap.set('n', '[b', "<cmd>bprevious<cr>")
vim.keymap.set('n', ']b', "<cmd>bnext<cr>")
vim.keymap.set('n', '[B', "<cmd>bfirst<cr>")
vim.keymap.set('n', ']B', "<cmd>blast<cr>")

-- Colorscheme
vim.opt.background = "light"
vim.cmd.colorscheme("default")
vim.cmd.highlight("Normal guibg=#ffffff")
vim.cmd.highlight("Comment gui=italic")
vim.cmd.highlight("DiagnosticUnderlineError guisp=red gui=undercurl")

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = false,
  severity_sort = true,
})
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  pattern = "*",
  callback = function()
    vim.diagnostic.setloclist({
      open = false,
    })
  end,
})

-- Lsp
vim.lsp.config("*", {
  -- I use asdf, so be sure to run commands globally. Otherwise, for things
  -- like Node, the correct binaries may not be used.
  cmd_cwd = vim.fn.expand("~"),
  root_markers = { ".git" },
})
vim.lsp.enable({
  "typescript",
  "eslint",
  "bash",
  "json",
  "lua",
})
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- if client ~= nil and client:supports_method('textDocument/completion') then
    --   vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    -- end
  end,
})

vim.opt.packpath = vim.env.VIMRUNTIME
vim.opt.packpath:append(vim.fn.stdpath("config"))

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end
})

do
  vim.cmd.packadd("finder")

  vim.keymap.set("n", "<leader>o", function()
    require("finder.scopes.paths").find()
  end)

  vim.keymap.set("n", "<leader>F", function()
    require("finder.scopes.files").find()
  end)

  vim.api.nvim_create_user_command(
    "Colorschemes",
    function()
      require("finder.scopes.colorschemes").find();
    end,
    {}
  )
end
