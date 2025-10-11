return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "LazyGit",
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 0 -- transparency (0 = none)
    vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scale to screen size
    vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
    vim.g.lazygit_floating_window_use_plenary = 0
    vim.g.lazygit_use_neovim_remote = 1
  end,
}
