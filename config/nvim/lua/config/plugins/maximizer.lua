return {
  "szw/vim-maximizer",
  event = "VeryLazy",
  config = function()
    -- Don’t set default mappings (you already did in which-key)
    vim.g.maximizer_set_default_mapping = 0
  end,
}
