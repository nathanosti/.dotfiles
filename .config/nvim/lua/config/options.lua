-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- -- Options são automaticamente carregados antes de lazy.nvim startup
-- Valores padrão estão em lua/lazyvim/config/options.lua

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

-- Transparência
opt.termguicolors = true
opt.winblend = 0
opt.pumblend = 0

-- Interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false

-- Tabs e indentação
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Clipboard
opt.clipboard = "unnamedplus"

vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection clipboard",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection clipboard -o",
  },
  cache_enabled = 1,
}

-- Backup
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Performance
opt.updatetime = 300
opt.timeoutlen = 400
