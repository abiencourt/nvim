return {
	{
		"saghen/blink.cmp",
		version = "*",
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"olimorris/codecompanion.nvim",
		},
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "codecompanion", "lazydev" },
				providers = {
					snippets = {
						min_keyword_length = 2,
						score_offset = 4,
					},
					lsp = {
						score_offset = 3,
					},
					path = {
						score_offset = 2,
					},
					buffer = {
						min_keyword_length = 5,
						score_offset = 1,
					},
					codecompanion = {
						name = "codecompanion",
						module = "codecompanion.providers.completion.blink",
						enabled = true,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 50,
					},
				},
			},
			completion = {
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
					},
				},
				ghost_text = {
					enabled = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
				},
			},
			keymap = {
				preset = "default",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-CR>"] = { "accept", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = {
					Copilot = " ",
					Text = "󰉿 ",
					Method = "󰊕 ",
					Function = "󰊕 ",
					Constructor = "󰒓 ",

					Field = "󰜢 ",
					Variable = "󰆦 ",
					Property = "󰖷 ",

					Class = "󱡠 ",
					Interface = "󱡠 ",
					Struct = "󱡠 ",
					Module = "󰅩 ",

					Unit = "󰪚 ",
					Value = "󰦨 ",
					Enum = "󰦨 ",
					EnumMember = "󰦨 ",

					Keyword = "󰻾 ",
					Constant = "󰏿 ",

					Snippet = "󱄽 ",
					Color = "󰏘 ",
					File = "󰈔 ",
					Reference = "󰬲 ",
					Folder = "󰉋 ",
					Event = "󱐋",
					Operator = "󰪚 ",
					TypeParameter = "󰬛 ",
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...
		event = "InsertEnter",
		config = true,
	},
}
