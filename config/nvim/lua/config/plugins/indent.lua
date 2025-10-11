return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "┆",        -- Character for indent line
      tab_char = "│",    -- Character for tabs
    },
    scope = {
      enabled = true,    -- Highlight current scope
      show_start = false,
      show_end = false,
      highlight = "Function", -- Highlight color of scope line
    },
    whitespace = {
      remove_blankline_trail = true,
    },
    exclude = {
      filetypes = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "NvimTree",
        "toggleterm",
      },
    },
  },
  config = function(_, opts)
    local ibl = require("ibl")

    -- Setup with provided options
    ibl.setup(opts)

    -- Optional: Dimmed colors for subtle indentation
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b3b3b" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7" }) -- Active scope color
  end,
}
