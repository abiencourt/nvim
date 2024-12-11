return {
	{
		"letieu/hacker.nvim",
		cmd = { "HackFollow" },
		keys = {
			{
				"<leader><leader>fh",
				"<cmd>HackFollow<cr>",
				desc = "Hack This File",
			},
		},
	},
	{
		"eandrju/cellular-automaton.nvim",
		cmd = { "CellularAutomaton" },
		keys = {
			{
				"<leader><leader>fr",
				"<cmd>CellularAutomaton make_it_rain<cr>",
				desc = "Make It Rain",
			},
		},
	},
	{
		"marcussimonsen/let-it-snow.nvim",
		cmd = { "LetItSnow" },
		keys = {
			{
				"<leader><leader>fs",
				"<cmd>LetItSnow<cr>",
				desc = "Let It Snow",
			},
		},
		opts = {},
	},
}
