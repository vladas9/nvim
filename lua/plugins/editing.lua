return {
	-- Vertical indent guides, with the current scope highlighted
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indent = { char = "\u{2502}", tab_char = "\u{2502}" },
			scope = { enabled = true, show_start = false, show_end = false },
			exclude = {
				filetypes = { "help", "NvimTree", "lazy", "mason", "snacks_dashboard", "toggleterm", "checkhealth" },
				buftypes = { "terminal", "nofile", "quickfix", "prompt" },
			},
		},
	},

	-- Auto-close brackets and quotes, aware of treesitter and the completion menu
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true, -- don't pair inside strings/comments where it makes no sense
			fast_wrap = { map = "<M-e>" }, -- Alt-e wraps the next word: (|foo -> (foo)
			disable_filetype = { "TelescopePrompt", "snacks_dashboard" },
		},
	},
}
