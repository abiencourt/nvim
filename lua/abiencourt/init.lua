require("abiencourt.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- import lazy safely
local status, lazy = pcall(require, "lazy")
if not status then
	return
end

local lazy_defaults = {
	defaults = {
		lazy = false,
	},
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
		check_pinned = false, -- check for pinned packages that can't be updated
	},
	ui = {
		border = "rounded",
	},
}

lazy.setup({
	{ import = "abiencourt.plugins" },
	{ import = "abiencourt.plugins.git" },
	{ import = "abiencourt.plugins.lsp-formatter-linter" },
	{ import = "abiencourt.plugins.navigation" },
	{ import = "abiencourt.plugins.terminal" },
	{ import = "abiencourt.plugins.theme" },
	{ import = "abiencourt.plugins.typing" },
	{ import = "abiencourt.plugins.language-specific" },
}, lazy_defaults)
