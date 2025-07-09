return {
	{
		"github/copilot.vim",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"olimorris/codecompanion.nvim",
		-- dir = "~/Coding/Personal/codecompanion.nvim/",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.5-sonnet",
							},
						},
					})
				end,
			},
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
