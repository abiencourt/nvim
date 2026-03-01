return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"olimorris/codecompanion.nvim",
		version = "v17.33.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					keymaps = {
						close = {
							modes = {
								n = "<A-c>",
								i = "<A-c>",
							},
						},
					},
				},
				inline = {
					adapter = "copilot",
				},
			},
			display = {
				chat = {
					window = {
						position = "right",
					},
				},
			},
		},
		keys = {
			{
				"<leader>c",
				function()
					require("codecompanion").toggle()
				end,
				desc = "Toggle Code Companion",
				mode = { "n", "v" },
			},
			{
				"<leader>cf",
				function()
					require("codecompanion").actions({})
				end,
				desc = "CodeCompanion Actions",
				mode = { "n", "v" },
			},
			{
				"<leader>cn",
				":CodeCompanionCmd ",
				desc = "CodeCompanion nvim command",
				mode = { "n" },
			},
			{
				"<leader>cc",
				":CodeCompanion ",
				desc = "CodeCompanion Inline Assistant",
				mode = { "n", "v" },
			},
		},
	},
}
