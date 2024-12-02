return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		config = function()
			local jsDebugAdapter = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						require("mason-registry").get_package("js-debug-adapter"):get_install_path()
							.. "/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}
			require("dap").adapters["pwa-node"] = jsDebugAdapter
			require("dap").adapters["pwa-chrome"] = jsDebugAdapter

			-- see https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md
			for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
				require("dap").configurations[language] = {
					{
						name = "Launch file",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						name = "Launch file for Revanista Development",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
						env = { AWS_PROFILE = "development" },
					},
					{
						name = "Launch file for Revanista QA",
						type = "pwa-node",
						request = "launch",
						program = "${file}",
						cwd = "${workspaceFolder}",
						env = { AWS_PROFILE = "qa" },
					},
					{
						-- can be used with `node --inspect-wait filename.js`
						name = "Attach to process",
						type = "pwa-node",
						request = "attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						name = "Run in Chrome Browser",
						type = "pwa-chrome",
						request = "launch",
						url = "http://localhost:3000",
						cwd = vim.fn.getcwd(),
						webRoot = "${workspaceFolder}",
						runtimeExecutable = "/var/lib/flatpak/exports/bin/com.google.Chrome",
					},
					{
						-- requires to run `flatpak run com.google.Chrome --remote-debugging-port=9222`
						name = "Attach to Chrome Browser",
						type = "pwa-chrome",
						request = "attach",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
