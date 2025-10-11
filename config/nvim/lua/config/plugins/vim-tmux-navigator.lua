return {
  "christoomey/vim-tmux-navigator",
  lazy = false, -- load immediately
  config = function()
    -- Prevent conflicts when tmux pane is zoomed
    vim.g.tmux_navigator_disable_when_zoomed = 1
  end,
}
