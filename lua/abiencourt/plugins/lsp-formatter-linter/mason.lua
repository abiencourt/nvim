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
		lsp_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- Rustaceanvim custom capabilities
		vim.g.rustacenvim = {
			server = {
				capabilities = lsp_capabilities,
				settings = {
					["rust-analyzer"] = {
						inlayHints = {
							bindingModeHints = { enable = false },
							chainingHints = { enable = true },
							closingBraceHints = { enable = true, minLines = 25 },
							closureReturnTypeHints = { enable = "never" },
							lifetimeElisionHints = { enable = "never", useParameterNames = false },
							maxLength = 25,
							parameterHints = { enable = true },
							reborrowHints = { enable = "never" },
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

		-- Native LSP configuration for each server
		local vim_lsp_config = vim.lsp.config

		-- Cypress Cucumber preprocessor
		vim_lsp_config("cucumber_language_server", {
			capabilities = lsp_capabilities,
			settings = {
				cucumber = {
					features = { "cypress/e2e/**/*.feature" },
					glue = { "cypress/e2e/**/*.ts" },
				},
			},
		})

		-- Lua
		vim_lsp_config("lua_ls", {
			capabilities = lsp_capabilities,
			settings = {
				Lua = { hint = { enable = true } },
			},
		})

		-- TSServer
		vim_lsp_config("ts_ls", {
			capabilities = lsp_capabilities,
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		-- JSON
		vim_lsp_config("jsonls", {
			capabilities = lsp_capabilities,
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		-- YAML
		vim_lsp_config("yamlls", {
			capabilities = lsp_capabilities,
			settings = {
				yaml = {
					keyOrdering = false,
					schemaStore = {
						enable = false,
						url = "",
					},
					schemas = require("schemastore").yaml.schemas(),
				},
			},
		})

		-- Python
		vim_lsp_config("pyright", {
			capabilities = lsp_capabilities,
		})

		require("mason-lspconfig").setup({
			-- By default, automatic_enable is true.
			-- Set to false if you want to manually enable servers.
			-- automatic_enable = true,
		})
	end,
}
