return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
  },
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
      options = {
        mode = "buffers", -- show buffers instead of tabs
        numbers = "ordinal", -- show buffer numbers (1,2,3…)
        diagnostics = "nvim_lsp", -- show LSP errors/warnings in bufferline
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    })

    -- Enable Catppuccin highlights for bufferline
    require("catppuccin").setup({
      integrations = {
        bufferline = true,
      },
    })

    -- Keymaps for buffer navigation
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- Next / Previous buffer
    map("n", "<S-l>", ":bnext<CR>", opts)
    map("n", "<S-h>", ":bprevious<CR>", opts)

    -- Close current buffer
    map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

    -- Close all except current
    map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all but current" })

    -- Jump to buffers by number (1–9)
    for i = 1, 9 do
      map("n", "<leader>" .. i, i .. "gt", { desc = "Go to buffer " .. i })
    end
  end,
}
