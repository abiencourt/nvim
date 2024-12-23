return {
	"phaazon/hop.nvim",
	branch = "v2",
	config = true,
	keys = {
		{
			"f",
			"<cmd>HopChar1CurrentLineAC<cr>",
			desc = "Hop Current Line After",
		},
		{
			"F",
			"<cmd>HopChar1CurrentLineBC<cr>",
			desc = "Hop Current Line Before",
		},
		{
			"<leader>h",
			"<cmd>HopChar1AC<cr>",
			desc = "Hop After",
		},
		{
			"<leader>H",
			"<cmd>HopChar1BC<cr>",
			desc = "Hop Before",
		},
		{
			"<leader><leader>h",
			"<cmd>HopChar2MW<cr>",
			desc = "Hop Anywhere",
		},
	},
}
