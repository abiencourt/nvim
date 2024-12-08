return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		words = { enabled = false },
		gitbrowse = { enabled = false },
		bigfile = {
			enabled = true,
			notify = true, -- show notification when big file detected
			size = 1.5 * 1024 * 1024, -- 1.5MB
			-- Enable or disable features when big file detected
			setup = function(ctx)
				vim.cmd([[NoMatchParen]])
				Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
				vim.schedule(function()
					vim.bo[ctx.buf].syntax = ctx.ft
				end)
			end,
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		styles = {
			notification = {
				wo = { wrap = true }, -- Wrap notifications
			},
		},
		quickfile = { enabled = true },
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = function()
							vim.cmd("TabRename " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~"))
							vim.cmd("Neotree position=current")
							vim.cmd("Telescope zoxide list")
						end,
					},
					{ icon = " ", key = "N", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "n",
						desc = "Neovim",
						action = function()
							vim.cmd("tcd $XDG_CONFIG_HOME/nvim")
							vim.cmd("TabRename Neovim Config")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "d",
						desc = "Dotfiles",
						action = function()
							vim.cmd("tcd $XDG_CONFIG_HOME")
							vim.cmd("TabRename DotFiles")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = "󰌵 ",
						key = "c",
						desc = "Chezmoi",
						action = function()
							vim.cmd("tcd $XDG_DATA_HOME/chezmoi")
							vim.cmd("TabRename Chezmoi")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = "󰒲 ",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
				{
					section = "terminal",
					cmd = "pokeget --hide-name --shiny rayquaza; sleep .1",
					random = 10,
					height = 25,
					indent = 8,
					pane = 2,
				},
			},
		},
	},
}
