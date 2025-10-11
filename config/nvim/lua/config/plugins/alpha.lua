return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 🌄 HEADER (Gruvbox styled)
    dashboard.section.header.val = {
      " ███╗   ██╗███████╗██╗   ██╗██╗███╗   ███╗",
      " ████╗  ██║██╔════╝██║   ██║██║████╗ ████║",
      " ██╔██╗ ██║█████╗  ██║   ██║██║██╔████╔██║",
      " ██║╚██╗██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
      " ██║ ╚████║███████╗  ╚████╔╝ ██║██║ ╚═╝ ██║",
      " ╚═╝  ╚═══╝╚══════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "            ⚡ Rahul’s Neovim Hub ⚡        ",
    }

    -- 🎯 SHORTCUT BUTTONS
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
      dashboard.button("SPC SPC", "󰱼  Find file", ":Telescope find_files<CR>"),
      dashboard.button("SPC f g", "󰈞  Live grep", ":Telescope live_grep<CR>"),
      dashboard.button("SPC f r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("SPC z p", "  Telekasten Panel", ":lua require('telekasten').panel()<CR>"),
      dashboard.button("SPC z d", "  Daily Note", ":Telekasten goto_today<CR>"),
      dashboard.button("SPC z w", "  Weekly Note", ":Telekasten goto_thisweek<CR>"),
      dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
    }

    -- 📜 FOOTER — Show Telekasten stats + plugin info
    dashboard.section.footer.val = function()
      local notes_path = vim.fn.expand("~/Documents/Notes")
      local count = tonumber(vim.fn.system("find " .. notes_path .. " -type f -name '*.md' | wc -l")) or 0

      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

      local footer = {
        "🗒️  " .. count .. " notes in your Zettelkasten",
        "⚙️  " .. stats.count .. " plugins loaded in " .. ms .. "ms",
        "  Gruvbox Material • " .. os.date("%A, %B %d %Y"),
      }

      return footer
    end

    -- 🎨 LAYOUT + STYLING
    dashboard.opts.opts.noautocmd = true
    dashboard.section.header.opts.hl = "GruvboxYellow"
    dashboard.section.buttons.opts.hl = "GruvboxAqua"
    dashboard.section.footer.opts.hl = "GruvboxGray"

    alpha.setup(dashboard.opts)

 end,
}

