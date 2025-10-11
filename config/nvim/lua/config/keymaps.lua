-- ============================
-- Basic Keymaps (no <leader>)
-- ============================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better movement in normal mode
map("n", "H", "^", opts) -- go to line start
map("n", "L", "$", opts) -- go to line end

-- Buffer navigation
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Exit insert mode quickly
map("i", "jk", "<Esc>", opts)

-- Split resizing (Alt + hjkl)
map("n", "<A-h>", "<C-w><", { desc = "Resize split left" })
map("n", "<A-l>", "<C-w>>", { desc = "Resize split right" })
map("n", "<A-j>", "<C-w>-", { desc = "Resize split down" })
map("n", "<A-k>", "<C-w>+", { desc = "Resize split up" })

-- ============================
-- Smooth small scrolling with arrow keys
-- ============================
map("n", "<Up>", "3<C-y>", { desc = "Scroll up (small)" })
map("n", "<Down>", "3<C-e>", { desc = "Scroll down (small)" })
map("n", "<Left>", "10zh", { desc = "Scroll left" })
map("n", "<Right>", "10zl", { desc = "Scroll right" })

map("v", "<Up>", "3<C-y>", { desc = "Scroll up (small, visual)" })
map("v", "<Down>", "3<C-e>", { desc = "Scroll down (small, visual)" })
map("v", "<Left>", "10zh", { desc = "Scroll left (visual)" })
map("v", "<Right>", "10zl", { desc = "Scroll right (visual)" })

-- ============================
-- Find & Replace Prompts
-- ============================

-- Case-sensitive replace (exact match)
map("n", "<leader>rs", function()
  local search = vim.fn.input("Find (case-sensitive): ")
  local replace = vim.fn.input("Replace with: ")
  if search ~= "" then
    vim.cmd(string.format("%%s/%s/%s/g", search, replace))
  end
end, { desc = "Replace (case-sensitive)" })

-- Case-insensitive replace (ignore case)
map("n", "<leader>ri", function()
  local search = vim.fn.input("Find (ignore case): ")
  local replace = vim.fn.input("Replace with: ")
  if search ~= "" then
    vim.cmd(string.format("%%s/%s/%s/gi", search, replace))
  end
end, { desc = "Replace (ignore case)" })
