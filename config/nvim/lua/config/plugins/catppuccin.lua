-- ~/.config/nvim/lua/config/plugins/catppuccin.lua
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			transparent_background = false,
			integrations = {
				telescope = true,
				treesitter = true,
				lsp_trouble = true,
				gitsigns = true,
				bufferline = true,
			},
		})
	end,
}
