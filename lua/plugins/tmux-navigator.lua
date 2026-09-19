return {
	"christoomey/vim-tmux-navigator",
	cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight", "TmuxNavigatePrevious" },
	keys = {
		{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window left" },
		{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window down" },
		{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window up" },
		{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window right" },
	},
	init = function()
		vim.g.tmux_navigator_no_mappings = 1 -- we define the keys above
	end,
}
