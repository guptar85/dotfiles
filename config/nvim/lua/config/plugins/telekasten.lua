-- ~/.config/nvim/lua/config/plugins/telekasten.lua
return {
	"renerocksai/telekasten.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"itchyny/calendar.vim", -- optional calendar support
	},
	config = function()
		local home = vim.fn.expand("~/Documents/Notes")

		require("telekasten").setup({
			-- Base notes directory
			home = home,

			-- Note structure
			dailies = home .. "/daily",
			weeklies = home .. "/weekly",
			templates = home .. "/templates",

			-- Templates
			template_new_note = home .. "/templates/new_note.md",
			template_new_daily = home .. "/templates/daily.md",
			template_new_weekly = home .. "/templates/weekly.md",

			-- File settings
			extension = ".md",
			new_note_filename = "title",
			uuid_type = "%Y%m%d%H%M",

			-- Behavior
			follow_creates_nonexisting = true,
			dailies_create_nonexisting = true,
			weeklies_create_nonexisting = true,

			-- Performance tweaks
			plug_into_calendar = false,
			command_palette_theme = "dropdown",
		})

		-- Force markdown filetype for Notes dir
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { home .. "/*.md", home .. "/**/*.md" },
			callback = function(event)
				vim.bo[event.buf].filetype = "markdown"
			end,
		})
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.getcwd() == vim.fn.expand("~/Documents/Notes") then
					require("telekasten").goto_note({ filename = "index.md" })
				end
			end,
		})
    -- ✅ Auto-enable render-markdown when entering a Telekasten note
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = home .. "/*.md",
      callback = function()
        vim.cmd("RenderMarkdown enable")
      end,
    })
	end,
}
