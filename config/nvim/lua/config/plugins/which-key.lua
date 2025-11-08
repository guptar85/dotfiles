-- ~/.config/nvim/lua/config/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    local builtin = require("telescope.builtin")
    local telescope = require("telescope")

    wk.setup({
      win = { border = "rounded" },
    })

    -- ============================
    -- Group labels
    -- ============================
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file" },
      { "<leader>g", group = "git" },
      { "<leader>s", group = "split" },
      { "<leader>t", group = "toggle" },
      { "<leader>x", group = "diagnostic" },
      { "<leader>d", group = "debug" },
      { "<leader>z", group = "zettelkasten" },
    })

    -- ============================
    -- Themes
    -- ============================
    wk.add({
      { "<leader>ut", group = "theme" },
      { "<leader>utg", "<cmd>colorscheme gruvbox-material<cr>", desc = "Gruvbox Material" },
      { "<leader>utc", "<cmd>colorscheme catppuccin<cr>", desc = "Catppuccin" },
    })

    -- ============================
    -- Leader mappings
    -- ============================
    wk.add({
      -- Yank / Paste whole buffer
      {
        "<leader>Y",
        function() vim.cmd('normal! ggVG"+y') end,
        desc = "Yank whole file to clipboard",
      },
      {
        "<leader>P",
        function() vim.cmd("%delete _ | 0put +") end,
        desc = "Replace buffer from clipboard",
      },

      -- Save & quit
      { "<leader>w", ":write<CR>", desc = "Save" },
      { "<leader>q", ":quit<CR>", desc = "Quit" },

      -- Clear search highlight
      { "<leader>h", ":nohlsearch<CR>", desc = "Clear highlight" },

      -- ============================
      -- Splits & buffers
      -- ============================
      { "<leader>sv", "<C-w>v", desc = "Split vertical" },
      { "<leader>sh", "<C-w>s", desc = "Split horizontal" },
      { "<leader>se", "<C-w>=", desc = "Equal size splits" },
      { "<leader>sx", ":close<CR>", desc = "Close split" },
      { "<leader>sm", "<cmd>MaximizerToggle<cr>", desc = "Toggle maximize split" },

      { "<leader>bn", ":bnext<CR>", desc = "Next buffer" },
      { "<leader>bp", ":bprevious<CR>", desc = "Previous buffer" },
      { "<leader>bd", ":bp|bd #<CR>", desc = "Delete current buffer safely" },
      { "<leader>bo", ":%bd|e#|bd#<CR>", desc = "Close all but current" },

      -- ============================
      -- Telescope (context-aware)
      -- ============================
      {
        "<leader><Space>",
        function()
          local cwd = vim.fn.expand("%:p:h")
          if cwd == "" or vim.fn.isdirectory(cwd) == 0 then
            cwd = vim.loop.cwd()
          end
          builtin.find_files({
            prompt_title = "📁 Files in " .. cwd,
            cwd = cwd,
            hidden = true,
          })
        end,
        desc = "Find files (context-aware)",
      },
      {
        "<leader>fg",
        function()
          local cwd = vim.fn.expand("%:p:h")
          if cwd == "" or vim.fn.isdirectory(cwd) == 0 then
            cwd = vim.loop.cwd()
          end
          builtin.live_grep({
            prompt_title = "🔍 Search in " .. cwd,
            cwd = cwd,
          })
        end,
        desc = "Live grep (context-aware)",
      },
      {
        "<leader>fG",
        function()
          builtin.live_grep({
            prompt_title = "🌍 Global search (CWD)",
          })
        end,
        desc = "Global live grep",
      },
      {
        "<leader>fe",
        function()
          local cwd = vim.fn.expand("%:p:h")
          if cwd == "" or vim.fn.isdirectory(cwd) == 0 then
            cwd = vim.loop.cwd()
          end
          telescope.extensions.file_browser.file_browser({
            path = cwd,
            select_buffer = true,
          })
        end,
        desc = "File browser (context-aware)",
      },
      {
        "<leader>fr",
        function()
          builtin.oldfiles({
            prompt_title = "📂 Recent Files (Global)",
            only_cwd = false,
          })
        end,
        desc = "Find recent files (global)",
      },
      {
        "<leader>/",
        function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            previewer = false,
            winblend = 10,
            layout_config = { width = 0.8, height = 0.6 },
          }))
        end,
        desc = "Fuzzy search in current file",
      },
      { "<leader>fo", "<cmd>Oil<cr>", desc = "Oil explorer" },
      {
        "<leader>?",
        function()
          builtin.keymaps(require("telescope.themes").get_dropdown({
            winblend = 10,
            layout_config = { width = 0.8, height = 0.6 },
          }))
        end,
        desc = "Search keymaps",
      },

      -- ============================
      -- Git (Telescope + LazyGit)
      -- ============================
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gc", builtin.git_commits, desc = "Git commits" },
      { "<leader>gb", builtin.git_branches, desc = "Git branches" },
      { "<leader>gs", builtin.git_status, desc = "Git status" },

      -- ============================
      -- Code (LSP + Formatting)
      -- ============================
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol" },
      {
        "<leader>cf",
        function() vim.lsp.buf.format({ async = true }) end,
        desc = "Format Code (LSP)",
      },
      { "<leader>cp", "<cmd>Prettier<cr>", desc = "Prettier Format" },
      { "<leader>cl", "<cmd>NullLsInfo<cr>", desc = "Lint sources (Null-ls info)" },

      -- ============================
      -- Trouble (diagnostics)
      -- ============================
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Document symbols" },
      { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References" },
      { "<leader>xi", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "Implementations" },
      { "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "Type definitions" },

      -- ============================
      -- Toggles (terminals, indent)
      -- ============================
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle last terminal" },
      {
        "<leader>th",
        function() require("toggleterm").toggle(15, "horizontal") end,
        desc = "Horizontal terminal",
      },
      {
        "<leader>tv",
        function() require("toggleterm").toggle(30, "vertical") end,
        desc = "Vertical terminal",
      },
      {
        "<leader>tf",
        function() require("toggleterm").toggle(nil, "float") end,
        desc = "Floating terminal",
      },
      {
        "<leader>tg",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
          lazygit:toggle()
        end,
        desc = "Lazygit terminal",
      },
      { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "Toggle indent guides" },
      { "<leader>tl", ":set invnumber<cr>", desc = "Toggle line numbers" },
      { "<leader>tr", ":set invrelativenumber<cr>", desc = "Toggle relative numbers" },

      -- ============================
      -- Telekasten (Notes)
      -- ============================
      { "<leader>zn", "<cmd>Telekasten new_note<cr>", desc = "New note" },
      {
        "<leader>zD",
        function() vim.cmd("edit " .. vim.fn.expand("~/Documents/Notes/index.md")) end,
        desc = "Dashboard (index.md)",
      },
      {
        "<leader>zp",
        function() require("telekasten").panel() end,
        desc = "Command Panel",
      },
      { "<leader>zd", "<cmd>Telekasten goto_today<cr>", desc = "Daily note" },
      { "<leader>zw", "<cmd>Telekasten goto_thisweek<cr>", desc = "Weekly note" },
      { "<leader>zf", "<cmd>Telekasten find_notes<cr>", desc = "Find notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<cr>", desc = "Search in notes" },
      { "<leader>zt", "<cmd>Telekasten show_tags<cr>", desc = "Show tags" },
      { "<leader>zr", "<cmd>Telekasten rename_note<cr>", desc = "Rename note" },
      { "<leader>zb", "<cmd>Telekasten backlinks<cr>", desc = "Show backlinks" },
      { "<leader>zc", "<cmd>Calendar -position=right<CR>", desc = "Calendar (from calendar.vim)" },
      { "<leader>zv", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Markdown preview" },
      { "<leader>zV", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview (browser)" },
    })
  end,
}
