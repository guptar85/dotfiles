-- ============================
-- Auto Commands
-- ============================

local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto resize splits when terminal resized
autocmd("VimResized", {
  command = "wincmd =",
})

autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("alpha").start()
    end
  end,
})
