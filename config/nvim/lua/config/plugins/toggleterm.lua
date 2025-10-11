-- ~/.config/nvim/lua/config/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.3)
        end
      end,
      open_mapping = [[<c-\>]], -- default toggle shortcut (Ctrl+\)
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- default terminal type
      float_opts = {
        border = "curved",
      },
    })
  end,
}