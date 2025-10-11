-- ~/.config/nvim/lua/config/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- Core features
      highlight = { enable = true },
      indent = { enable = true },

      -- Textobjects: select functions, classes, etc.
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- jump forward to nearest textobject
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    })
  end,
}
