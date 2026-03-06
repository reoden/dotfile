return function()
	local icons = { aichat = require("modules.utils.icons").get("aichat", true) }
	local secret_key = require("core.settings").chat_api_key
	local chat_lang = require("core.settings").chat_lang
	local models = require("core.settings").chat_models

	vim.g.current_chat_model = models[1]

	require("modules.utils").load_plugin("codecompanion", {
		opts = {
			language = chat_lang,
		},

		strategies = {
			chat = {
				adapter = "claudecode",

				roles = {
					llm = function(adapter)
						return icons.aichat.Copilot .. " Claude (" .. adapter.formatted_name .. ")"
					end,
					user = icons.aichat.Me .. " Me",
				},

				keymaps = {
					submit = {
						modes = { n = "<CR>" },
						description = "Submit",
						callback = function(chat)
							chat:submit()
						end,
					},
				},
			},

			inline = {
				adapter = "claudecode",
			},

			cmd = {
				adapter = "claudecode",
			},
		},

		adapters = {
			http = {
				claudecode = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://aicoding.dobest.com",
							api_key = secret_key,
							chat_url = "/v1/chat/completions",
						},

						schema = {
							model = {
								default = vim.g.current_chat_model,
							},
						},

						opts = {
							stream = true,
							temperature = 0.2,
						},
					})
				end,
			},
		},

		display = {
			diff = {
				enabled = true,
				provider = "inline",

				provider_opts = {
					inline = {
						layout = "float",
					},
				},

				split = {
					layout = "vertical",

					opts = {
						"internal",
						"filler",
						"closeoff",
						"algorithm:histogram",
						"indent-heuristic",
						"followwrap",
						"linematch:120",
					},
				},
			},

			chat = {
				window = {
					border = "single",
					layout = "vertical",
					position = "right",
					width = 0.25,
					auto_scroll = true,
				},
			},
		},

		extensions = {
			history = {
				enabled = true,

				opts = {
					keymap = "gh",
					auto_generate_title = true,
					picker = "telescope",
					auto_save = true,

					dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
				},
			},
		},
	})

	vim.api.nvim_create_user_command("ChatModel", function()
		vim.ui.select(models, { prompt = "Select Claude Model" }, function(choice)
			if choice then
				vim.g.current_chat_model = choice
				print("CodeCompanion model -> " .. choice)
			end
		end)
	end, {})
end
