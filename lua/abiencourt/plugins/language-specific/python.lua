return {
	"benomahony/uv.nvim",
	ft = "python",
	config = function()
		require("uv").setup({
			keymaps = {
				prefix = "<leader>U",
			},
		})
	end,
}
