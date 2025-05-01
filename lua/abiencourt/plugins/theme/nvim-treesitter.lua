return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		opts = function()
			local tsc = require("treesitter-context")
			---@module 'snacks'
			Snacks.toggle({
				name = "Treesitter Context",
				get = tsc.enabled,
				set = function(state)
					if state then
						tsc.enable()
					else
						tsc.disable()
					end
				end,
			}):map("<leader>T")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			{ "windwp/nvim-ts-autotag", opts = { opts = { enable_close_on_slash = true } } },
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = {
					"json",
					"javascript",
					"typescript",
					"angular",
					"tsx",
					"yaml",
					"html",
					"css",
					"markdown",
					"markdown_inline",
					"bash",
					"lua",
					"vim",
					"vimdoc",
					"dockerfile",
					"gitignore",
					"regex",
					"hyprlang",
					"git_config",
					"regex",
					"bash",
				},
				highlight = { enable = true },
				autotag = { enable = false },
				indent = { enable = true },
				-- select blocks with <CR>
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<CR>",
						node_incremental = "<CR>",
						scope_incremental = "<S-CR>",
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
}
