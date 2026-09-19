return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix", -- compact popup in the bottom-right corner
		delay = 300,
		icons = { mappings = true, rules = false },
		win = { border = "rounded" },
		spec = {
			-- Group names shown in the popup
			{ "<leader>f", group = "find", icon = "\u{f002}" },
			{ "<leader>g", group = "git", icon = "\u{e725}" },
			{ "<leader>l", group = "lsp", icon = "\u{f085}" },
			{ "<leader>a", group = "ai", icon = "\u{f0d0}" },
			{ "<leader>t", group = "terminal", icon = "\u{f120}" },
			{ "[", group = "prev" },
			{ "]", group = "next" },
			{ "g", group = "goto" },
			{ "z", group = "fold" },
		},
	},
}
