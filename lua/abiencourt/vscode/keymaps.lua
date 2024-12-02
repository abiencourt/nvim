local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- yank to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({ "n", "v" }, "<leader>p", '"+p', opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- vscode commands
keymap({ "n", "v" }, "<leader>e", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")
keymap({ "n", "v" }, "<leader>=", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")
keymap({ "n", "v" }, "<leader>fl", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>")
keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- Switch between relative and absolute line numbers based on mode/buffer focus
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
	callback = function()
		vim.opt_local.relativenumber = true
		vim.opt_local.number = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "InsertEnter" }, {
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = true
	end,
})
