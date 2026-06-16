-- Neovim configuration migrated from ~/.vimrc
-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic settings
vim.opt.hidden = true
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.laststatus = 2  -- Always show status line

-- Bash-like tabbing
vim.opt.wildmode = "longest,list,full"
vim.opt.wildmenu = true

vim.opt.history = 5000
vim.opt.undolevels = 1000
vim.opt.wildignore = "*.swp,*.bak,*.pyc,*.class"
vim.opt.title = true
vim.opt.visualbell = false
vim.opt.errorbells = false

-- Disable backup buffers
vim.opt.backup = false
vim.opt.swapfile = false

-- Highlight evil whitespaces
vim.opt.list = true
vim.opt.listchars = { tab = ">.", trail = ".", extends = "#", nbsp = "." }

-- Disable list for Go files
vim.cmd([[
  autocmd FileType go setlocal nolist
]])

-- Better responsiveness (for LSP, etc.)
vim.opt.updatetime = 300

-- Always show the signcolumn
vim.opt.signcolumn = "yes"

-- Key mappings
local keymap = vim.keymap.set

-- Exit insert mode shortcuts
keymap("i", "jj", "<Esc>", { silent = true })
keymap("i", "jk", "<Esc>", { silent = true })
keymap("i", "kj", "<Esc>", { silent = true })
keymap("i", "kk", "<Esc>", { silent = true })

keymap("n", ";", ":", { noremap = true })
keymap("n", "j", "gj", { noremap = true })
keymap("n", "k", "gk", { noremap = true })

-- Make yank Y behave like C and D
keymap("n", "Y", "y$", { noremap = true })

-- Center search display
keymap("n", "n", "nzz", { noremap = true })
keymap("n", "N", "Nzz", { noremap = true })
keymap("n", "*", "*zz", { noremap = true })
keymap("n", "#", "#zz", { noremap = true })
keymap("n", "g*", "g*zz", { noremap = true })
keymap("n", "g#", "g#zz", { noremap = true })

-- Keep selection after in/outdent
keymap("v", "<", "<gv", { noremap = true })
keymap("v", ">", ">gv", { noremap = true })

-- Better command mode navigation
keymap("c", "<C-j>", "<down>", { noremap = true })
keymap("c", "<C-k>", "<up>", { noremap = true })

-- Sudo save a file after editing it
keymap("c", "w!!", "w !sudo tee % >/dev/null", { noremap = true })

-- Fix syntax coloring issues for long lines
vim.opt.synmaxcol = 300

-- QuickFix window behavior
vim.cmd([[
  autocmd QuickFixCmdPost [^l]* nested cwindow
  autocmd QuickFixCmdPost    l* nested lwindow
]])

-- Use ripgrep by default for grepping
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Quickfix jump bindings
keymap("n", "<Leader>n", ":cn<CR>", { silent = true })
keymap("n", "<Leader>N", ":cp<CR>", { silent = true })

-- Clipboard integration
-- WSL2 clipboard configuration
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-- Use system clipboard for all yank/delete/paste operations
vim.opt.clipboard = "unnamedplus"

-- Additional explicit clipboard shortcuts
keymap("v", "<Leader>y", '"+y', { noremap = true, desc = "Yank to clipboard" })
keymap("n", "<Leader>y", '"+yiw', { noremap = true, desc = "Yank word to clipboard" })
keymap("n", "<Leader>p", '"+p', { noremap = true, desc = "Paste from clipboard" })
keymap("v", "<Leader>p", '"+p', { noremap = true, desc = "Paste from clipboard" })

-- Open file from same directory
keymap("n", "<Leader>e", ":e <C-R>=expand('%:p:h') . '/'<CR>", { noremap = true })

-- Tig integration
vim.cmd([[
  command! -nargs=0 -bar Tig execute '! tig %'
]])

-- Insert current date
keymap("n", "<Leader>t", ":put =strftime('%Y-%m-%d')<CR>", { noremap = true })

-- Execute current line as shell command
keymap("n", "<Leader>r", ":.!sh<CR>", { noremap = true })

-- Save shortcuts
keymap("n", "<C-s>", ":w <CR>", { noremap = true })
keymap("v", "<C-s>", ":w <CR>", { noremap = true })

-- Node global version support
vim.env.ASDF_NODEJS_VERSION = "18.1.0"

-- Disable folding for markdown files
vim.cmd([[
  autocmd FileType markdown setlocal nofoldenable
]])

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

-- Load additional keymaps that depend on plugins
require("config.keymaps")
