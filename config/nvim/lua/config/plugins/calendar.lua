-- ~/.config/nvim/lua/config/plugins/calendar.lua
return {
	"itchyny/calendar.vim",
	cmd = { "Calendar", "CalendarH", "CalendarT" }, -- lazy-load only when you open it
	init = function()
		-- Optional: Start week on Monday instead of Sunday
		vim.g.calendar_monday = 1

		-- Optional: Show ISO week numbers
		vim.g.calendar_weeknm = 4

		-- Optional: Highlight today
		vim.g.calendar_mark = "today"
	end,
}
