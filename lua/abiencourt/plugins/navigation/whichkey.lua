-- Used to configure keymaps
-- Can be listed through telescope
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

		-- ####################################################################
		-- Default keymaps

		-- Search Highlight
		wk.add({
			{
				"<leader>/",
				"<cmd>:noh<cr>",
				desc = "Clear Search Highlight",
			},
		})

		-- Yank/paste
		wk.add({
			mode = { "n", "v" },
			{ "<leader>y", '"+y', desc = "Yank to System Clipboard" },
			{ "<leader>p", '"+p', desc = "Paste from System Clipboard" },
		})

		wk.add({
			mode = { "n", "v" },
			{ "<leader><leader>d", '"_dd', desc = "Delete using Void Buffer" },
			{ "<leader><leader>p", '"_dP', desc = "Paste and Delete using Void Buffer" },
		})

		-- Windows
		wk.add({
			{
				"<C-w>",
				group = "Windows",
			},
			{
				"<C-w>n",
				"<cmd>vsplit<cr>",
				desc = "Open New Window vertically",
			},
			{
				"<C-w>x",
				"<C-w>c",
				desc = "Close Current Window",
			},
		})

		-- Buffers
		wk.add({
			{
				"<C-h>",
				"<cmd>bprevious<cr>",
				desc = "Previous buffer",
			},
			{
				"<C-l>",
				"<cmd>bnext<cr>",
				desc = "Next buffer",
			},
		})

		-- Create line and stay at same position
		wk.add({
			{
				"<leader>o",
				"mzo<ESC>`z",
				desc = "Create line below",
			},
			{
				"<leader>O",
				"mzO<ESC>`z",
				desc = "Create line above",
			},
		})

		-- Move highlighted text
		wk.add({
			mode = { "v" },
			{
				"J",
				":m '>+1<cr>gv=gv",
				desc = "Move Text to Next line",
			},
			{ "K", ":m '<-2<cr>gv=gv", desc = "Move Text to Previous line" },
		})

		-- Quickfix
		wk.add({
			{ "[q", "<cmd>QNext<cr>", desc = "Previous Quickfix" },
			{ "]q", "<cmd>QPrev<cr>", desc = "Next Quickfix" },
			{ "<leader>q", group = "Quickfix" },
			{ "<leader>qq", "<cmd>QFToggle<cr>", desc = "Toggle Quickfix" },
			{ "<leader>ql", "<cmd>LLToggle<cr>", desc = "Toggle Loclist" },
			{ "<leader>qd", "<cmd>Reject<cr>", desc = "Remove Item From Quickfix" },
			{
				"<leader>qc",
				":cdo ",
				desc = "Do for all ",
				buffer = nil,
				silent = false, -- silent = false makes the command line appear
				noremap = true,
				nowait = false,
			},
		})

		-- Scroll down
		wk.add({
			mode = { "n", "v", "i" },
			{
				"<c-s>",
				"<c-e>",
				desc = "Scroll down",
			},
		})

		-- Escape
		wk.add({
			mode = { "n", "v", "i" },
			{
				"<c-c>",
				"<esc>",
				desc = "Escape",
			},
		})

		-- ####################################################################
		-- Plugins

		-- Create groups for plugins using lazy keys
		wk.add({
			{ "<leader>m", group = "Markdown" },
			{ "<leader>c", group = "Copilot", icon = { icon = "", color = "orange" } },
			{
				"<leader><leader>f",
				group = "Fun",
			},
		})

		wk.setup({
			preset = "modern",
		})
	end,
}
