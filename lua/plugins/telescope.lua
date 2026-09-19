return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- file type icons in the results list
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
		{ "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", mode = "x", desc = "Grep selection" },
		{ "<leader>fb", "<cmd>Telescope buffers sort_mru=true<cr>", desc = "Buffers" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
		{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
		{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
	},
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				prompt_prefix = "  \u{f002}  ",
				-- Caret and prefix must have the same display width, otherwise rows shift on selection
				selection_caret = "\u{f054} ",
				entry_prefix = "  ",
				multi_icon = "\u{f00c} ",
				path_display = { "filename_first" },
				sorting_strategy = "ascending",
				results_title = false,
				dynamic_preview_title = true,
				winblend = 0,
				-- Borderless panels: the theme colours the panel backgrounds, so hide the border lines
				borderchars = {
					prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
					results = { " ", " ", " ", " ", " ", " ", " ", " " },
					preview = { " ", " ", " ", " ", " ", " ", " ", " " },
				},
				-- Side-by-side preview on wide terminals, stacked on narrow ones. Preview is always shown.
				layout_strategy = "flex",
				layout_config = {
					width = 0.9,
					height = 0.85,
					flex = { flip_columns = 130 },
					horizontal = { prompt_position = "top", preview_width = 0.55, preview_cutoff = 0 },
					vertical = { prompt_position = "top", mirror = true, preview_height = 0.45, preview_cutoff = 0 },
				},
				file_ignore_patterns = { "^%.git/", "node_modules/", "^dist/", "^build/", "%.lock$" },
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<Esc>"] = actions.close, -- no normal mode in the prompt
					},
				},
			},
			pickers = {
				find_files = { hidden = true },
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end,
}
