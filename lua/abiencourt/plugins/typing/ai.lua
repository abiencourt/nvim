return {
	{
		"Exafunction/codeium.nvim",
		event = "BufReadPre",
		keys = { {
			"<leader>cc",
			"<cmd>Codeium Chat<cr>",
			desc = "Codeium Chat",
		} },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = false,
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"abiencourt/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			strategies = {
				chat = {
					adapter = "copilot",
					keymaps = {
						close = {
							modes = {
								n = "<esc>",
								i = "<esc>",
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
