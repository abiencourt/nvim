return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		words = { enabled = false },
		gitbrowse = { enabled = false },
		toggle = {
			enabled = true,
			map = vim.keymap.set, -- keymap.set function to use
			which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
			notify = true, -- show a notification when toggling
			-- icons for enabled/disabled states
			icon = {
				enabled = " ",
				disabled = " ",
			},
			-- colors for enabled/disabled states
			color = {
				enabled = "green",
				disabled = "yellow",
			},
		},
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
						icon = "📂",
						key = "p",
						desc = "Find project",
						action = function()
							vim.cmd("Neotree position=current")
							vim.cmd("Telescope zoxide list")
						end,
					},
					{
						icon = "📝",
						key = "f",
						desc = "Find file",
						action = function()
							vim.cmd("Telescope find_files hidden=true")
						end,
					},
					{
						icon = "📑",
						key = "N",
						desc = "New File",
						action = ":ene | startinsert",
					},
					{
						icon = "📦",
						key = "n",
						desc = "Neovim",
						action = function()
							vim.cmd("tcd $XDG_CONFIG_HOME/nvim")
							vim.cmd("TabRename Neovim Config")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = "⌛",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = "🔧",
						key = "d",
						desc = "Dotfiles",
						action = function()
							vim.cmd("tcd $XDG_CONFIG_HOME")
							vim.cmd("TabRename DotFiles")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = "🏠",
						key = "c",
						desc = "Chezmoi",
						action = function()
							vim.cmd("tcd $XDG_DATA_HOME/chezmoi")
							vim.cmd("TabRename Chezmoi")
							vim.cmd("Neotree position=current")
						end,
					},
					{
						icon = "💤",
						key = "l",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = "📤", key = "q", desc = "Quit", action = ":qa" },
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
	init = function()
		---@module 'snacks'
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spell Check" }):map("<leader>z")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>N")
			end,
		})
	end,
}
