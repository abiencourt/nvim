return {
	{
		"Exafunction/codeium.nvim",
		event = "BufReadPre",
		enabled = false, -- waiting for https://github.com/Exafunction/codeium.nvim/pull/264
		keys = { {
			"<leader>cC",
			"<cmd>Codeium Chat<cr>",
			desc = "Codeium Chat",
		} },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
	},
	{
		config = function()
				},
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		-- dir = "~/Coding/Personal/codecompanion.nvim/",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			adapters = {
				-- copilot = function()
				-- 	return require("codecompanion.adapters").extend("copilot", {
				-- 		schema = {
				-- 			model = {
				-- 				default = "claude-3.5-sonnet",
				-- 			},
				-- 		},
				-- 	})
				-- end,
				litellm = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://litellm.cloud.bncrt.com/v1",
							api_key = vim.env.LITELLM_API_KEY,
							chat_url = "/chat/completions",
						},
						schema = {
							model = {
								default = "bedrock-claude-3-sonnet",
							},
						},
						handlers = {
							form_parameters = function(self, params, messages)
								-- Clean messages by extracting only role and content
								-- This removes extra fields like id, opts, cycle that API doesn't accept
								local cleaned_messages = {}
								for _, msg in ipairs(messages) do
									table.insert(cleaned_messages, {
										role = msg.role,
										content = msg.content,
									})
								end

								-- Create a copy of parameters to avoid modifying original
								local parameters = vim.deepcopy(params)

								-- Flatten nested 'options' into top-level parameters
								-- This ensures all configuration options are at the root level
								if parameters.options then
									for k, v in pairs(parameters.options) do
										parameters[k] = v
									end
									parameters.options = nil
								end

								-- Return a clean parameter object for the API request
								return {
									model = parameters.model,
									messages = cleaned_messages,
									temperature = parameters.temperature,
									max_tokens = parameters.max_tokens,
									top_p = parameters.top_p,
									top_k = parameters.top_k,
								}
							end,
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "litellm",
					keymaps = {
						close = {
							modes = {
								n = "<A-c>",
								i = "<A-c>",
							},
						},
					},
				},
				inline = {
					adapter = "litellm",
				},
			},
			display = {
				chat = {
					window = {
						position = "right",
					},
				},
			},
		},
		keys = {
			{
				"<leader>c",
				function()
					require("codecompanion").toggle()
				end,
				desc = "Toggle Code Companion",
				mode = { "n", "v" },
			},
			{
				"<leader>cf",
				function()
					require("codecompanion").actions({})
				end,
				desc = "CodeCompanion Actions",
				mode = { "n", "v" },
			},
			{
				"<leader>cn",
				":CodeCompanionCmd ",
				desc = "CodeCompanion nvim command",
				mode = { "n" },
			},
			{
				"<leader>cc",
				":CodeCompanion ",
				desc = "CodeCompanion Inline Assistant",
				mode = { "n", "v" },
			},
		},
	},
}
