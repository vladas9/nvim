return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeSelectModel" },
	opts = {
		terminal = { split_side = "right", split_width_percentage = 0.35 },
	},
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Send selection to Claude" },
		{ "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file from tree", ft = { "NvimTree" } },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
