return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6", -- stable release
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-file-browser.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
        file_ignore_patterns = { "node_modules", ".git" },
      },

      extensions = {
        file_browser = {
          hijack_netrw = true,
          hidden = true,
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },

      pickers = {
        oldfiles = {
          prompt_title = "📂 Recent Files",
          only_cwd = true, -- show only files from current project
          theme = "dropdown",
          previewer = false,
          layout_config = {
            width = 0.6,
            height = 0.5,
          },
        },
      },
    })

    -- ✅ Load extensions cleanly
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
  end,
}
