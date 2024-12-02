return {
	-- Smooth cursor movement.
	{
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Smooth scrolling.
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		config = function()
			require("neoscroll").setup({})
		end,
	},
}
