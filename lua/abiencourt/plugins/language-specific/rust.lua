return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		ft = { "rust" },
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		tag = "stable",
		config = function()
			require("crates").setup({
				lsp = {
					enabled = true,
					on_attach = function(client, bufnr)
						-- the same on_attach function as for your other lsp's
					end,
					actions = true,
					completion = true,
					hover = true,
				},
			})

			require("which-key").add({
				{
					"<leader>c",
					group = "Crates",
				},
				{
					"<leader>cs",
					function()
						require("crates").toggle()
					end,
					desc = "Show Crates virtual lines",
				},
				{
					"<leader>cv",
					function()
						require("crates").show_versions_popup()
					end,
					desc = "Show Crates versions",
				},
				{
					"<leader>cf",
					function()
						require("crates").show_features_popup()
					end,
					desc = "Show Crates features",
				},
				{
					"<leader>cd",
					function()
						require("crates").show_dependencies_popup()
					end,
					desc = "Show Crates dependencies",
				},
				{
					"<leader>cu",
					function()
						require("crates").update_crate()
					end,
					desc = "Update crate",
				},
				{
					"<leader>ca",
					function()
						require("crates").update_all_crates()
					end,
					desc = "Update All Crates",
				},
				{
					"<leader>cx",
					function()
						require("crates").expand_plain_crate_to_inline_table()
					end,
					desc = "Expand Plain Crate To Inline Table",
				},
				{
					"<leader>ch",
					function()
						require("crates").open_homepage()
					end,
					desc = "Open Crate Homepage",
				},
				{
					"<leader>cr",
					function()
						require("crates").open_repository()
					end,
					desc = "Open Crate Repository",
				},
				{
					"<leader>cD",
					function()
						require("crates").open_documentation()
					end,
					desc = "Open Crate Documentation",
				},
				{
					"<leader>cc",
					function()
						require("crates").open_crates_io()
					end,
					desc = "Open Crates.io",
				},
			})
		end,
	},
}
