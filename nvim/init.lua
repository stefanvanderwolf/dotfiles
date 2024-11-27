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
vim.keymap.set('n', '!q', "<cmd>chistory<cr>")
vim.keymap.set('n', '<q', "<cmd>colder<cr>")
vim.keymap.set('n', '>q', "<cmd>cnewer<cr>")
vim.keymap.set('n', '[q', "<cmd>cprevious<cr>")
vim.keymap.set('n', ']q', "<cmd>cnext<cr>")
vim.keymap.set('n', '[Q', "<cmd>cfirst<cr>")
vim.keymap.set('n', ']Q', "<cmd>clast<cr>")

-- Location list
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
vim.cmd.colorscheme("zenwritten")

vim.opt.packpath = vim.env.VIMRUNTIME
vim.opt.packpath:append(vim.fn.stdpath("config"))
