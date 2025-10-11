-- ~/.config/nvim/lua/config/plugins/colorscheme.lua
return {
	{
		"sainnhe/gruvbox-material",
		lazy = false, -- load at startup
		priority = 1000, -- make sure it loads first
		config = function()
			-- Options before colorscheme
			vim.g.gruvbox_material_background = "hard" -- "soft", "medium", "hard"
			vim.g.gruvbox_material_foreground = "mix" -- "material", "mix", "original"
			vim.g.gruvbox_material_better_performance = 1

			-- Transparent background?
			-- vim.g.gruvbox_material_transparent_background = 1

			-- Load the theme
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
