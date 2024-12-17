return {
	"nanozuki/tabby.nvim",
	config = function()
		require("tabby.tabline").use_preset("tab_only", {
			tab_name = {
				name_fallback = function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
				end,
			},
		})

		require("which-key").add({
			{
				"<c-t>",
				group = "Tabs",
			},
			{ "<c-t>r", ":TabRename ", desc = "Rename Tab" },
			{ "<c-t>n", "<cmd>tabnew<cr>", desc = "New Tab" },
			{ "<c-t>x", "<cmd>tabclose<cr>", desc = "Close Tab" },
			{ "<c-t>l", "<cmd>tabn<cr>", desc = "Go to Right Tab" },
			{ "<c-t>h", "<cmd>tabp<cr>", desc = "Go to Left Tab" },
		})
	end,
}
