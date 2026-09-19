return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "x" },
			desc = "Format",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofumpt" },
			python = { "ruff_organize_imports", "ruff_format" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			sh = { "shfmt" },
			["_"] = { "trim_whitespace" }, -- any other filetype
		},
		default_format_opts = { lsp_format = "fallback" }, -- use the LSP if no formatter is listed
		format_on_save = function(bufnr)
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 1000 }
		end,
	},
	config = function(_, opts)
		require("conform").setup(opts)

		-- :FormatToggle flips format-on-save globally, :FormatToggle! for the current buffer only
		vim.api.nvim_create_user_command("FormatToggle", function(args)
			if args.bang then
				vim.b.disable_autoformat = not vim.b.disable_autoformat
				vim.notify("Format on save (buffer): " .. (vim.b.disable_autoformat and "off" or "on"))
			else
				vim.g.disable_autoformat = not vim.g.disable_autoformat
				vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
			end
		end, { bang = true })
	end,
}
