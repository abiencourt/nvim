return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
				},
			})
		end,
	},
	{
		"joshuavial/aider.nvim",
		keys = {
			{
				"<leader>a",
				"<cmd>AiderOpen<cr>",
				desc = "Aider",
			},
		},
		opts = {
			auto_manage_context = true, -- automatically manage buffer context
			default_bindings = false,
			debug = false,
		},
	},
}
