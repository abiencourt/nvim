return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	build = ":MasonUpdate",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
		"kevinhwang91/nvim-ufo",
		"b0o/schemastore.nvim",
		"stevearc/conform.nvim",
		"mrcjkb/rustaceanvim",
		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		},
	},
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		-- Auto update schemastore at startup
		require("lazy").update({ plugins = { "schemastore.nvim" }, show = false })

		local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Add folding capabilities required by ufo.nvim
		lsp_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- local lsp_attach = function(client, bufnr)
		--              -- Create your keybindings here...
		--              -- Could it be used to display the name of the schema?
		--              -- SchemaStore.nvim cannot do it for us
		-- end

		-- Adds capabilities to rustaceanvim
		vim.g.rustacenvim = {
			server = {
				capabilities = lsp_capabilities,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = {
								enable = false,
							},
							chainingHints = {
								enable = true,
							},
							closingBraceHints = {
								enable = true,
								minLines = 25,
							},
							closureReturnTypeHints = {
								enable = "never",
							},
							lifetimeElisionHints = {
								enable = "never",
								useParameterNames = false,
							},
							maxLength = 25,
							parameterHints = {
								enable = true,
							},
							reborrowHints = {
								enable = "never",
							},
							renderColons = true,
							typeHints = {
								enable = true,
								hideClosureInitialization = false,
								hideNamedConstructor = false,
							},
						},
					},
				},
			},
		}

		require("typescript-tools").setup({
			-- on_attach = function() ... end,
			handlers = {
				capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
			},
			settings = {
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
				-- "remove_unused_imports"|"organize_imports") -- or string "all"
				-- to include all supported code actions
				-- specify commands exposed as code_actions
				expose_as_code_action = {},
				-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
				-- not exists then standard path resolution strategy is applied
				tsserver_path = nil,
				-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
				-- (see 💅 `styled-components` support section)
				tsserver_plugins = {},
				-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
				-- memory limit in megabytes or "auto"(basically no limit)
				tsserver_max_memory = "auto",
				-- described below
				tsserver_format_options = {},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
				},
				-- locale of all tsserver messages, supported locales you can find here:
				-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
				tsserver_locale = "en",
				-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
				complete_function_calls = false,
				include_completions_with_insert_text = true,
				-- CodeLens
				-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
				-- possible values: ("off"|"all"|"implementations_only"|"references_only")
				code_lens = "off",
				-- by default code lenses are displayed on all referencable values and for some of you it can
				-- be too much this option reduce count of them by removing member references from lenses
				disable_member_code_lens = true,
				-- JSXCloseTag
				-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
				-- that maybe have a conflict if enable this feature. )
				jsx_close_tag = {
					enable = false,
					filetypes = { "javascriptreact", "typescriptreact" },
				},
			},
		})

		local lspconfig = require("lspconfig")
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					-- on_attach = lsp_attach,
					capabilities = lsp_capabilities,
				})
			end,

			-- Rust
			-- Do not spin up rust-analyzer automatically because it starts with rustacenvim
			["rust_analyzer"] = function() end,

			-- TSServer
			-- Do not spin up ts_ls automatically because it starts with typescript-tools
			["ts_ls"] = function() end,

			-- Cypress Cucumber preprocessor https://github.com/badeball/cypress-cucumber-preprocessor
			["cucumber_language_server"] = function()
				lspconfig.cucumber_language_server.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						cucumber = {
							features = { "cypress/e2e/**/*.feature" },
							glue = { "cypress/e2e/**/*.ts" },
						},
					},
				})
			end,

			-- Lua
			["lua_ls"] = function()
				lspconfig.lua_ls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						Lua = {
							hint = {
								enable = true,
							},
						},
					},
				})
			end,

			-- JSON
			["jsonls"] = function()
				lspconfig.jsonls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				})
			end,

			-- YAML
			["yamlls"] = function()
				lspconfig.yamlls.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
					settings = {
						yaml = {
							keyOrdering = false,
							schemaStore = {
								-- You must disable built-in schemaStore support if you want to use this plugin and its advanced options like `ignore`.
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				})
			end,

			-- Python
			["pyright"] = function()
				lspconfig.pyright.setup({
					capabilities = lsp_capabilities, -- Needs to be added manually for each LSP
				})
			end,
		})
	end,
}
