return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle terminal" },
		{
			"<leader>tg",
			function()
				require("toggleterm.terminal").Terminal
					:new({ cmd = "lazygit", direction = "float", hidden = true })
					:toggle()
			end,
			desc = "Lazygit",
		},
	},
	opts = {
		open_mapping = nil, -- mapped via keys above
		direction = "float",
		float_opts = {
			border = "rounded",
			width = function()
				return math.floor(vim.o.columns * 0.85)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.8)
			end,
		},
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			end
			if term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4)
			end
		end,
		shade_terminals = false, -- keep the theme background
		start_in_insert = true,
		persist_size = true,
		shell = vim.o.shell,
	},
}
