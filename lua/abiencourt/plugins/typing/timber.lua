return {
	"Goose97/timber.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("timber").setup({
			default_keymaps_enabled = true,
		})
		require("which-key").add({
			{ "<leader>t", group = "Timber" },
			{
				"<leader>tj",
				function()
					require("timber.actions").insert_log({ position = "below" })
				end,
				desc = "Log below",
				mode = { "n", "v" },
			},
			{
				"<leader>tk",
				function()
					require("timber.actions").insert_log({ position = "above" })
				end,
				desc = "Log below",
				mode = { "n", "v" },
			},
			{
				"<leader>ta",
				function()
					require("timber.actions").add_log_targets_to_batch()
				end,
				desc = "Add log target to batch",
				mode = { "n", "v" },
			},
			{
				"<leader>tb",
				function()
					require("timber.actions").insert_batch_log()
				end,
				desc = "Insert batch log",
				mode = { "n" },
			},
			{
				"<leader>tb",
				function()
					require("timber.actions").insert_batch_log({ auto_add = true })
				end,
				desc = "Insert batch log (including highlight)",
				mode = { "v" },
			},
		})
	end,
}
