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
      { "<leader>x", group = "diagnostic" }, -- Trouble / diagnostics
      { "<leader>d", group = "debug" },   -- Debugging (DAP)
      { "<leader>z", group = "zettelkasten" },
    })

    -- ============================
    -- Themes
    -- ============================
    wk.add({
      { "<leader>ut",  group = "theme" },
      { "<leader>utg", "<cmd>colorscheme gruvbox-material<cr>", desc = "Gruvbox Material" },
      { "<leader>utc", "<cmd>colorscheme catppuccin<cr>",       desc = "Catppuccin" },
    })

    -- ============================
    -- Leader mappings
    -- ============================
    wk.add({
      -- Yank / Paste whole buffer
      {
        "<leader>Y",
        function()
          vim.cmd('normal! ggVG"+y')
        end,
        desc = "Yank whole file to clipboard",
      },
      {
        "<leader>P",
        function()
          vim.cmd("%delete _ | 0put +")
        end,
        desc = "Replace buffer from clipboard",
      },

      -- Save & quit
      { "<leader>w",       ":write<CR>",               desc = "Save" },
      { "<leader>q",       ":quit<CR>",                desc = "Quit" },

      -- Clear search highlight
      { "<leader>h",       ":nohlsearch<CR>",          desc = "Clear highlight" },

      -- Window splits
      { "<leader>sv",      "<C-w>v",                   desc = "Split vertical" },
      { "<leader>sh",      "<C-w>s",                   desc = "Split horizontal" },
      { "<leader>se",      "<C-w>=",                   desc = "Equal size splits" },
      { "<leader>sx",      ":close<CR>",               desc = "Close split" },
      { "<leader>sm",      "<cmd>MaximizerToggle<cr>", desc = "Toggle maximize split" },

      -- Buffers
      { "<leader>bn",      ":bnext<CR>",               desc = "Next buffer" },
      { "<leader>bp",      ":bprevious<CR>",           desc = "Previous buffer" },
      { "<leader>bd",      ":bp|bd #<CR>",             desc = "Delete current buffer safely" },
      { "<leader>bo",      ":%bd|e#|bd#<CR>",          desc = "Close all but current" },

      -- Telescope (search & files)
      { "<leader><Space>", builtin.find_files,         desc = "Find files (root)" },
      { "<leader>fg",      builtin.live_grep,          desc = "Live grep (root)" },
      {
        "<leader>fw",
        function()
          builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end,
        desc = "Live grep word under cursor",
      },
      {
        "<leader>fd",
        function()
          builtin.find_files({ cwd = vim.fn.getcwd(), hidden = true })
        end,
        desc = "Find files (cwd)",
      },
      {
        "<leader>fs",
        function()
          builtin.live_grep({ cwd = vim.fn.getcwd() })
        end,
        desc = "Live grep (cwd)",
      },
      { "<leader>fb", builtin.buffers,   desc = "Find buffers" },
      { "<leader>fh", builtin.help_tags, desc = "Find help" },
      {
        "<leader>fe",
        function()
          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            select_buffer = true,
          })
        end,
        desc = "File browser",
      },
      -- Keymap for recent files
      { "leader>fr", builtin.oldfiles, desc = "Find recent files" },
      -- 🔍 NEW: Fuzzy search inside current file
      {
        "<leader>/",
        function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            previewer = false,
            winblend = 10,
            layout_config = {
              width = 0.8, -- 80% of the screen width
              height = 0.6, -- 60% of the screen height
            },
            borderchars = {
              prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
              results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
              preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },
          }))
        end,
        desc = "Fuzzy search in current file (larger window)",
      },
      { "<leader>fo", "<cmd>Oil<cr>",     desc = "Oil explorer" },
      {
        "<leader>?",
        function()
          require("telescope.builtin").keymaps(require("telescope.themes").get_dropdown({
            winblend = 10,
            layout_config = { width = 0.8, height = 0.6 },
          }))
        end,
        desc = "Search keymaps",
      },

      -- Git (Telescope)
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      {
        "<leader>gc",
        function()
          builtin.git_commits()
        end,
        desc = "Git commits",
      },
      {
        "<leader>gb",
        function()
          builtin.git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>gs",
        function()
          builtin.git_status()
        end,
        desc = "Git status",
      },

      -- Debug (DAP)
      {
        "<F5>",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into (ABAP F5)",
      },
      {
        "<F6>",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over (ABAP F6)",
      },
      {
        "<F7>",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out (ABAP F7)",
      },
      {
        "<F8>",
        function()
          require("dap").continue()
        end,
        desc = "Continue (ABAP F8)",
      },
      {
        "<S-F8>",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor (ABAP Shift+F8)",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint (ABAP F9)",
      },
      {
        "<S-F9>",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Conditional Breakpoint (ABAP Shift+F9)",
      },

      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Conditional BP",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<leader>ds",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>du",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dt",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle UI",
      },
      {
        "<leader>dp",
        function()
          require("dap").pause()
        end,
        desc = "Pause",
      },

      -- 🔥 Clear all breakpoints
      {
        "<leader>dC",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Clear all breakpoints",
      },

      {
        "<leader>dv",
        function()
          if vim.g.dap_signs_hidden then
            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "Visual" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })
            vim.g.dap_signs_hidden = false
            print("🔵 Breakpoint signs: visible")
          else
            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "" })
            vim.fn.sign_define("DapStopped", { text = "", texthl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "" })
            vim.g.dap_signs_hidden = true
            print("🚫 Breakpoint signs: hidden")
          end
        end,
        desc = "Toggle breakpoint signs (gutter clutter)",
      },
      -- DAP windows
      { "<leader>dw", "<C-w>w",                desc = "Cycle DAP windows" },
      {
        "<leader>da",
        function()
          require("dap").run({
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node (9229)",
            cwd = vim.fn.getcwd(),
            port = 9229,
          })
        end,
        desc = "Attach to Node (9229)",
      },

      -- Code (LSP + Formatting)
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
      { "<leader>cr", vim.lsp.buf.rename,      desc = "Rename symbol" },
      {
        "<leader>cf",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Format Code (LSP)",
      },
      { "<leader>cp", "<cmd>Prettier<cr>",                                desc = "Prettier Format" },
      { "<leader>cl", "<cmd>NullLsInfo<cr>",                              desc = "Lint sources (Null-ls info)" },

      -- Trouble (diagnostics / LSP lists)
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Workspace diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Document symbols" },
      { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>",           desc = "References" },
      { "<leader>xi", "<cmd>Trouble lsp_implementations toggle<cr>",      desc = "Implementations" },
      { "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<cr>",     desc = "Type definitions" },

      -- Git (Gitsigns)
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage hunk",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset hunk",
      },
      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview hunk",
      },
      {
        "<leader>gS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "Stage buffer",
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset buffer",
      },
      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Diff against index",
      },
      {
        "<leader>gD",
        function()
          require("gitsigns").diffthis("~")
        end,
        desc = "Diff against last commit",
      },
      {
        "<leader>gt",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle line blame",
      },

      -- Toggles (terminals + options)
      { "<leader>tt", "<cmd>ToggleTerm<cr>",          desc = "Toggle last terminal" },
      {
        "<leader>th",
        function()
          require("toggleterm").toggle(15, "horizontal")
        end,
        desc = "Horizontal terminal",
      },
      {
        "<leader>tv",
        function()
          require("toggleterm").toggle(30, "vertical")
        end,
        desc = "Vertical terminal",
      },
      {
        "<leader>tf",
        function()
          require("toggleterm").toggle(nil, "float")
        end,
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

      -- Option toggles
      { "<leader>tl", ":set invnumber<cr>",           desc = "Toggle line numbers" },
      { "<leader>tr", ":set invrelativenumber<cr>",   desc = "Toggle relative numbers" },

      -- Telekasten (Note management)
      { "<leader>zn", "<cmd>Telekasten new_note<cr>", desc = "New note" },
      {
        "<leader>zD",
        function()
          vim.cmd("edit " .. vim.fn.expand("~/Documents/Notes/index.md"))
        end,
        desc = "Dashboard (index.md)",
      },
      {
        "<leader>zp",
        function()
          require("telekasten").panel()
        end,
        desc = "Command Panel",
      },
      { "<leader>zd", "<cmd>Telekasten goto_today<cr>",    desc = "Daily note" },
      { "<leader>zw", "<cmd>Telekasten goto_thisweek<cr>", desc = "Weekly note" },
      { "<leader>zf", "<cmd>Telekasten find_notes<cr>",    desc = "Find notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<cr>",  desc = "Search in notes" },
      { "<leader>zt", "<cmd>Telekasten show_tags<cr>",     desc = "Show tags" },
      { "<leader>zr", "<cmd>Telekasten rename_note<cr>",   desc = "Rename note" },
      { "<leader>zb", "<cmd>Telekasten backlinks<cr>",     desc = "Show backlinks" },
      { "<leader>zc", "<cmd>Calendar -position=right<CR>", desc = "Calendar (from calendar.vim)" },
      { "<leader>zv", "<cmd>RenderMarkdown toggle<cr>",    desc = "Toggle Markdown preview" },
      { "<leader>zV", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview (browser)" },
    })
  end,
}
