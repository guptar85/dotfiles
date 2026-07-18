return {
  "iamcco/markdown-preview.nvim",
  -- Uses the plugin's internal installer for better reliability on macOS
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  -- Ensure it loads for standard markdown and your Telekasten notes
  ft = { "markdown", "telekasten", "mermaid" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  init = function()
    -- Core Behavior
    vim.g.mkdp_auto_start = 0              -- Trigger manually with :MarkdownPreview
    vim.g.mkdp_auto_close = 1              -- Clean up browser tabs when you're done
    vim.g.mkdp_refresh_slow = 0            -- "0" means real-time sync as you type

    -- UI & Browser
    vim.g.mkdp_browser = "safari"          -- Set to "arc", "chrome", or "brave" if preferred
    vim.g.mkdp_echo_preview_url = 1        -- Useful for debugging the local server port
    vim.g.mkdp_theme = "dark"              -- Sets the base CSS to dark mode
    vim.g.mkdp_page_title = "${name} — Notes Preview"
    vim.g.mkdp_port = "9999"               -- Fixed port to avoid conflicts

    -- Mermaid & Advanced Rendering
    -- This section forces Mermaid to render with a dark aesthetic
    vim.g.mkdp_preview_options = {
      mmarkdown = {},
      description_container = {},
      mermaid = {
        theme = 'dark',                    -- Matches your VIM/System theme
        flowchart = { curve = 'linear' }   -- Makes diagrams look sharper
      },
      katex = {},
      uml = {},
      toc = {}
    }
  end,
}

