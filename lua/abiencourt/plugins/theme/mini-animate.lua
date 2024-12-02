return {
	"echasnovski/mini.animate",
	version = "*",
	event = "VeryLazy",
	config = function()
		vim.opt.mousescroll = "ver:30,hor:6"
		require("mini.animate").setup({
			-- Cursor path
			cursor = {
				enable = false,
			},

			-- Vertical scroll
			scroll = {
				enable = false,
			},

			-- Window resize
			resize = {
				enable = true,
			},

			-- Window open
			open = {
				enable = true,
			},

			-- Window close
			close = {
				enable = true,
			},
		})
	end,
}
