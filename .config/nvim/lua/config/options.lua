-- Options gerais para LazyVim e múltiplos idiomas

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

-- Tabs e indentação: Cada linguagem pode sobrescrever em plugin
opt.tabstop = 2    -- JS/TS/Ruby
opt.shiftwidth = 2 -- JS/TS/Ruby
opt.expandtab = true
opt.autoindent = true

-- Exemplo: sobrescrever shiftwidth/tabstop para linguagens específicas via autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "cpp", "c", "java", "go" },
  callback = function()
    if vim.bo.filetype == "python" then
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
    elseif vim.bo.filetype == "cpp" or vim.bo.filetype == "c" or vim.bo.filetype == "java" or vim.bo.filetype == "go" then
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
    end
  end,
})

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
