return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		config = function()
			vim.diagnostic.config({ severity_sort = true }) -- displays the popups

			require("lspsaga").setup({
				preview = {
					lines_above = 5,
					lines_below = 10,
				},
				scroll_preview = {
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
				},
				request_timeout = 2000,
				finder = {
					--percentage
					max_height = 0.5,
					keys = {
						jump_to = "p",
						edit = { "o", "<CR>" },
						vsplit = "s",
						split = "i",
						tabe = "t",
						tabnew = "r",
						quit = { "q", "<ESC>", "<C-c>" },
						close_in_preview = "<ESC>",
					},
				},
				definition = {
					edit = "<C-c>o",
					vsplit = "<C-c>v",
					split = "<C-c>i",
					tabe = "<C-c>t",
					quit = "q",
					close = "<Esc>",
					back = "<C-c>b",
					next = "<C-c>n",
				},
				code_action = {
					num_shortcut = true,
					show_server_name = true,
					extend_gitsigns = true,
					keys = {
						-- string | table type
						quit = { "q", "<ESC>", "<C-c>" },
						exec = "<CR>",
					},
				},
				lightbulb = {
					enable = false,
					sign = false,
					sign_priority = 40,
					virtual_text = true,
				},
				diagnostic = {
					on_insert = true,
					on_insert_follow = false,
					insert_winblend = 0,
					show_code_action = true,
					show_source = true,
					jump_num_shortcut = true,
					--1 is max
					max_width = 0.7,
					custom_fix = nil,
					custom_msg = nil,
					text_hl_follow = false,
					border_follow = true,
					keys = {
						exec_action = "o",
						quit = "q",
						go_action = "g",
					},
				},
				rename = {
					quit = "<C-c>",
					exec = "<CR>",
					mark = "x",
					confirm = "<CR>",
					in_select = true,
				},
				outline = {
					win_position = "right",
					win_with = "",
					win_width = 30,
					show_detail = true,
					auto_preview = true,
					auto_refresh = true,
					auto_close = true,
					custom_sort = nil,
					keys = {
						jump = "<CR>",
						expand_collapse = "u",
						quit = "q",
					},
				},
				callhierarchy = {
					show_detail = false,
					keys = {
						edit = "e",
						vsplit = "s",
						split = "i",
						tabe = "t",
						jump = "o",
						quit = "q",
						expand_collapse = "u",
					},
				},
				symbol_in_winbar = {
					enable = true,
					separator = " ",
					ignore_patterns = {},
					hide_keyword = true,
					show_file = false,
					-- folder_level = 2,
					respect_root = true,
					color_mode = true,
				},
				beacon = {
					enable = true,
					frequency = 7,
				},
				ui = {
					-- This option only works in Neovim 0.9
					title = true,
					-- Border type can be single, double, rounded, solid, shadow.
					border = "single",
					winblend = 0,
					expand = "",
					collapse = "",
					code_action = "💡",
					hover = " ",
					kind = {},
				},
			})

			require("which-key").add({
				{ "<leader>l", group = "LSP" },
				{
					"<leader>lc",
					"<cmd>Lspsaga code_action<cr>",
					desc = "LSP Code Action",
				},
				{
					"<leader>lf",
					"<cmd>Lspsaga finder<cr>",
					desc = "Lspsaga Definition Finder",
				},
				{
					"<leader>lv",
					function()
						local config = vim.diagnostic.config()
						if config and config.virtual_text == true then
							vim.diagnostic.config({
								virtual_text = false,
							})
						else
							vim.diagnostic.config({
								virtual_text = true,
							})
						end
					end,
					desc = "Toggle LSP Virtual Text",
				},
				{
					"<leader>lo",
					"<cmd>Lspsaga outline<cr>",
					desc = "Lspsaga Outline",
				},
				{
					"<leader>lr",
					"<cmd>Lspsaga rename<cr>",
					desc = "Lspsaga Rename",
				},
			})

			require("which-key").add({
				{
					"<leader>ld",
					group = "diagnostics",
				},
				{
					"<leader>ldl",
					"<cmd>Lspsaga show_line_diagnostics<cr>",
					desc = "Lspsaga Show Line Diagnostics",
				},
				{
					"<leader>ldb",
					"<cmd>Lspsaga show_buf_diagnostics<cr>",
					desc = "Lspsaga Show Buffer Diagnostics",
				},
				{
					"<leader>ldw",
					"<cmd>Lspsaga show_workspace_diagnostics<cr>",
					desc = "Lspsaga Show Workspace Diagnostics",
				},
			})

			require("which-key").add({
				{ "g", group = "Lspsaga Definition" },
				{
					"gd",
					"<cmd>Lspsaga goto_definition<cr>",
					desc = "Lspsaga Goto Definition",
				},
				{
					"gD",
					"<cmd>Lspsaga peek_definition<cr>",
					desc = "Lspsaga Peek Definition",
				},
				{
					"gt",
					"<cmd>Lspsaga goto_type_definition<cr>",
					desc = "Lspsaga Goto Type Definition",
				},
				{
					"gT",
					"<cmd>Lspsaga peek_type_definition<cr>",
					desc = "Lspsaga Peek Type Definition",
				},
				{
					"K",
					"<cmd>Lspsaga hover_doc<cr>",
					desc = "Lspsaga Hover Doc",
				},
				{
					"[d",
					"<cmd>Lspsaga diagnostic_jump_prev<cr>",
					desc = "Lspsaga Diagnostic Jump Prev",
				},
				{
					"]d",
					"<cmd>Lspsaga diagnostic_jump_next<cr>",
					desc = "Lspsaga Diagnostic Jump Next",
				},
			})
		end,
	},
}
