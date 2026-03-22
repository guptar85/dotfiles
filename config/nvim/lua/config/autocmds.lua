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

-- Identify Structurizr DSL files
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.dsl",
  callback = function()
    vim.bo.filetype = "structurizr"
    vim.bo.commentstring = "// %s"
  end,
})
-- Create a shortcut to compile Structurizr DSL to Mermaid
vim.api.nvim_create_user_command("StructurizrExport", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("!structurizr-cli export -w " .. file .. " -format mermaid")
  print("Exported Structurizr to Mermaid!")
end, {})
