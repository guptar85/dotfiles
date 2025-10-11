return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true, -- safer deletes
      keymaps = {
        -- Standard navigation
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["<C-r>"] = "actions.refresh",
        ["g?"] = "actions.show_help", -- Show help menu

        -- Create new file/dir
        ["n"] = {
          callback = function()
            vim.cmd.normal("o") -- new line below, enter insert mode
          end,
          desc = "Create a new file or directory",
        },

        -- Rename file/dir
        ["r"] = {
          callback = function()
            vim.cmd.normal("cw") -- edit word under cursor
          end,
          desc = "Rename file or directory",
        },
      },
    })

    -- Global shortcut to open Oil
    vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open Oil explorer" })
  end,
}
