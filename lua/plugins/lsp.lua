-- Servers installed by Mason. Keys are lspconfig names, values are per-server settings.
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				workspace = { checkThirdParty = false },
				completion = { callSnippet = "Replace" },
				hint = { enable = true },
			},
		},
	},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				staticcheck = true,
				usePlaceholders = true,
				analyses = { unusedparams = true, unusedwrite = true, nilness = true },
				hints = { parameterNames = true, assignVariableTypes = true },
			},
		},
	},
	basedpyright = {
		settings = {
			basedpyright = {
				analysis = { typeCheckingMode = "standard", autoImportCompletions = true },
			},
		},
	},
	vtsls = {
		settings = {
			typescript = { inlayHints = { parameterNames = { enabled = "literals" } } },
		},
	},
}

return {
	-- Package manager for LSP servers, formatters, linters
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = { ui = { border = "rounded" } },
	},

	-- Neovim API types for lua_ls when editing this config
	{ "folke/lazydev.nvim", ft = "lua", opts = {} },

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
			{
				"mason-org/mason-lspconfig.nvim",
				dependencies = { "mason-org/mason.nvim" },
				opts = {
					ensure_installed = vim.tbl_keys(servers),
					automatic_enable = true, -- calls vim.lsp.enable() for every installed server
				},
			},
		},
		config = function()
			-- Diagnostics look
			vim.diagnostic.config({
				severity_sort = true,
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 2, prefix = "\u{25cf}" },
				float = { border = "rounded", source = true },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "\u{f057} ",
						[vim.diagnostic.severity.WARN] = "\u{f071} ",
						[vim.diagnostic.severity.INFO] = "\u{f05a} ",
						[vim.diagnostic.severity.HINT] = "\u{f0eb} ",
					},
				},
			})

			-- Completion capabilities from blink.cmp, applied to every server
			vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

			-- Per-server settings
			for name, cfg in pairs(servers) do
				vim.lsp.config(name, cfg)
			end

			-- Buffer-local keymaps and features once a server attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
				callback = function(ev)
					local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, "Hover")
					map("i", "<C-s>", function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, "Signature help")
					map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
					map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")

					-- Highlight other occurrences of the symbol under the cursor
					if client:supports_method("textDocument/documentHighlight") then
						local group = vim.api.nvim_create_augroup("user_lsp_highlight_" .. ev.buf, { clear = true })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							group = group,
							buffer = ev.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
							group = group,
							buffer = ev.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})
		end,
	},
}
