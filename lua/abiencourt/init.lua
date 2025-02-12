require("abiencourt.set")
require("abiencourt.env")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- import lazy safely
local status, lazy = pcall(require, "lazy")
if not status then
	return
end

local lazy_defaults
local lazy_imports

if vim.g.vscode then
	require("abiencourt.vscode.keymaps")

	lazy_defaults = {
		defaults = {
			lazy = false,
		},
		checker = {
			enabled = false, -- automatically check for plugin updates
			notify = false, -- get a notification when new updates are found
			check_pinned = false, -- check for pinned packages that can't be updated
		},
		change_detection = {
			enabled = false,
		},
	}

	lazy_imports = {
		import = "abiencourt.vscode.plugins",
	}
else
	lazy_defaults = {
		defaults = {
			lazy = false,
		},
		checker = {
			enabled = true, -- automatically check for plugin updates
			concurrency = nil, ---@type number? set to 1 to check for updates very slowly
			notify = true, -- get a notification when new updates are found
			frequency = 3600, -- check for updates every hour
			check_pinned = false, -- check for pinned packages that can't be updated
		},
		ui = {
			border = "rounded",
		},
	}

	lazy_imports = {
		{ import = "abiencourt.plugins" },
		{ import = "abiencourt.plugins.git" },
		{ import = "abiencourt.plugins.language-specific" },
		{ import = "abiencourt.plugins.lsp-formatter-linter" },
		{ import = "abiencourt.plugins.navigation" },
		{ import = "abiencourt.plugins.terminal" },
		{ import = "abiencourt.plugins.theme" },
		{ import = "abiencourt.plugins.typing" },
	}
end

lazy.setup(lazy_imports, lazy_defaults)
