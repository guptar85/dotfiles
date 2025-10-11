return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "telekasten" }, -- only load for markdown + telekasten notes
  opts = {
    enabled = true, -- enable by default
    debounce = 200, -- delay for live rendering updates
    file_types = { "markdown", "telekasten" },

    -- Heading styles
    heading = {
      enabled = true,
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " }, -- icons per level
      signs = { "=", "-", "~", ".", "~", "." }, -- underline styles
    },

    -- Code blocks
    code = {
      enabled = true,
      style = "minimal", -- "minimal" or "fancy"
    },

    -- Checkboxes
    checkbox = {
      enabled = true,
      checked = "", -- fancy checkmark
      unchecked = "",
      custom = {
        pending = { raw = "[-]", rendered = "", hl = "Todo" },
      },
    },

    -- Blockquotes
    quote = {
      enabled = true,
      icon = "▎",
    },

    -- Tables
    table = {
      enabled = true,
      style = "rounded",
    },
  },
}
