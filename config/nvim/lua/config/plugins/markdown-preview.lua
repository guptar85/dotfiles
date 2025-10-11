return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install", -- auto-install dependencies
  ft = { "markdown", "telekasten" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  init = function()
    vim.g.mkdp_auto_start = 0              -- don't start automatically
    vim.g.mkdp_auto_close = 1              -- auto close when leaving buffer
    vim.g.mkdp_refresh_slow = 0            -- live update on edit
    vim.g.mkdp_browser = "safari"          -- or "arc" / "chrome" / "brave"
    vim.g.mkdp_echo_preview_url = 1        -- show URL when opened
    vim.g.mkdp_theme = "dark"              -- match your Gruvbox setup
    vim.g.mkdp_page_title = "${name} — Notes Preview"
    vim.g.mkdp_port = "9999"
  end,
}
