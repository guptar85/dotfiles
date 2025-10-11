-- ============================
-- General Options
-- ============================

local opt = vim.opt

-- UI
opt.number = true            -- line numbers
opt.relativenumber = true    -- relative line numbers
opt.cursorline = true        -- highlight current line
opt.termguicolors = true     -- true color support
opt.signcolumn = "yes"       -- always show sign column
opt.wrap = false             -- no line wrap

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Undo/backup
opt.undofile = true
opt.swapfile = false
opt.backup = false
