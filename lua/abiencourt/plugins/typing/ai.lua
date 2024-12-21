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
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			model = "claude-3.5-sonnet",
			mappings = {
				close = {
					normal = "q",
					insert = "<esc>",
				},
			},
		},
		keys = {
			{
				"<leader>C",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "Toggle Copilot Chat",
				mode = { "n", "v" },
			},
			{
				"<leader>cr",
				function()
					require("CopilotChat").reset()
				end,
				desc = "Reset Copilot Chat",
				mode = { "n", "v" },
			},
			{
				"<leader>fC",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "Pick a prompt",
				mode = { "n", "v" },
			},
		},
	},
}
