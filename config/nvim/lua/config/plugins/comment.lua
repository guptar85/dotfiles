return {
  "numToStr/Comment.nvim",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      toggler = {
        line = "gcc", -- toggle line comment
        block = "gbc", -- toggle block comment
      },
      opleader = {
        line = "gc",  -- comment with motion (e.g. gcaw, gc})
        block = "gb", -- block comment with motion
      },
    })
  end,
}
