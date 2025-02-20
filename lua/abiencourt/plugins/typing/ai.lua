return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("minuet").setup({
				notify = "debug",
				provider = "openai_compatible",
				n_completions = 1,
				context_window = 512,
				provider_options = {
					openai_compatible = {
						model = "bedrock-claude-3-5-sonnet-v2",
						end_point = "https://litellm.cloud.bncrt.com/v1/chat/completions",
						api_key = function()
							return vim.env.LITELLM_API_KEY
						end,
						name = "litellm",
						stream = true,
						optional = {
							stop = nil,
							max_tokens = 300,
						},
					},
				},
			})
		end,
	},
	{
		"joshuavial/aider.nvim",
		keys = {
			{
				"<leader>a",
				"<cmd>AiderOpen<cr>",
				desc = "Aider",
			},
		},
		opts = {
			auto_manage_context = true, -- automatically manage buffer context
			default_bindings = false,
			debug = false,
		},
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
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = "claude-3.5-sonnet",
							},
						},
					})
				end,
				litellm = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://litellm.cloud.bncrt.com/v1",
							api_key = vim.env.LITELLM_API_KEY,
							chat_url = "/chat/completions",
						},
						schema = {
							model = {
								default = "bedrock-claude-3-5-sonnet-v2",
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
