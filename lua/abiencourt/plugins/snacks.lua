return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {

		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
	---@type snacks.Config
	opts = {
		words = { enabled = false },
		gitbrowse = { enabled = false },
		dim = { enabled = true },
		lazygit = { enabled = true },
		quickfile = { enabled = true },
		toggle = {
			enabled = true,
			map = vim.keymap.set, -- keymap.set function to use
			which_key = true,
			notify = true,
			icon = {
				enabled = " ",
				disabled = " ",
			},
			color = {
				enabled = "green",
				disabled = "yellow",
			},
		},
		scope = {
			enbled = true,
			-- absolute minimum size of the scope.
			-- can be less if the scope is a top-level single line scope
			min_size = 2,
			-- try to expand the scope to this size
			max_size = nil,
			cursor = true, -- when true, the column of the cursor is used to determine the scope
			edge = true, -- include the edge of the scope (typically the line above and below with smaller indent)
			siblings = false, -- expand single line scopes with single line siblings
			-- what buffers to attach to
			filter = function(buf)
				return vim.bo[buf].buftype == ""
			end,
			-- debounce scope detection in ms
			debounce = 30,
			treesitter = {
				-- detect scope based on treesitter.
				-- falls back to indent based detection if not available
				enabled = true,
				---@type string[]|{enabled?:boolean}
				blocks = {
					enabled = false, -- enable to use the following blocks
					"function_declaration",
					"function_definition",
					"method_declaration",
					"method_definition",
					"class_declaration",
					"class_definition",
					"do_statement",
					"while_statement",
					"repeat_statement",
					"if_statement",
					"for_statement",
				},
				-- these treesitter fields will be considered as blocks
				field_blocks = {
					"local_declaration",
				},
			},
			-- These keymaps will only be set if the `scope` plugin is enabled.
			-- Alternatively, you can set them manually in your config,
			-- using the `Snacks.scope.textobject` and `Snacks.scope.jump` functions.
			keys = {
				---@type table<string, snacks.scope.TextObject|{desc?:string}>
				textobject = {
					ii = {
						min_size = 2, -- minimum size of the scope
						edge = false, -- inner scope
						cursor = false,
						treesitter = { blocks = { enabled = false } },
						desc = "inner scope",
					},
					ai = {
						cursor = false,
						min_size = 2, -- minimum size of the scope
						treesitter = { blocks = { enabled = false } },
						desc = "full scope",
					},
				},
				---@type table<string, snacks.scope.Jump|{desc?:string}>
				jump = {
					["[i"] = {
						min_size = 1, -- allow single line scopes
						bottom = false,
						cursor = false,
						edge = true,
						treesitter = { blocks = { enabled = false } },
						desc = "jump to top edge of scope",
					},
					["]i"] = {
						min_size = 1, -- allow single line scopes
						bottom = true,
						cursor = false,
						edge = true,
						treesitter = { blocks = { enabled = false } },
						desc = "jump to bottom edge of scope",
					},
				},
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
				Snacks.toggle.dim():map("<leader>d")
				Snacks.toggle.inlay_hints():map("<leader>lh")
			end,
		})
	end,
}
