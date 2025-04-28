return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	opts = {
		auto_update = true,
		run_on_start = true,
		ensure_installed = {
			-- LSP servers
			"json-lsp",
			"lua-language-server",
			"typescript-language-server",
			"angular-language-server",
			"cucumber-language-server",
			"yaml-language-server",
			"marksman",
			"bash-language-server",
			"rust-analyzer",
			"hyprls",
			"pyright",
			"terraform-ls",

			-- Formatters
			"stylua",
			"shfmt",
			"markdown-toc",
			"codespell",
			"xmlformatter",
			"taplo",
			"prettier",
			"black",

			-- Linters
			"markdownlint", -- and formatter
			"tflint",
			"cfn-lint",
			"alex",
			"actionlint",
			"proselint",
			"write-good",
			"yamllint",
			"jsonlint",
			"eslint_d",
			"mypy",
			"ruff",
			"shellcheck", -- used by bash-language-server, no config required in nvim-lint

			-- DAP
			"js-debug-adapter",
			"debugpy",
		},
	},
}
