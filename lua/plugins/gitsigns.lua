return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "\u{258e}" },
			change = { text = "\u{258e}" },
			delete = { text = "\u{2581}" },
			topdelete = { text = "\u{2594}" },
			changedelete = { text = "\u{258e}" },
			untracked = { text = "\u{258e}" },
		},
		signs_staged_enable = true,
		current_line_blame = false, -- toggle with <leader>gB
		current_line_blame_opts = { delay = 500, virt_text_pos = "eol" },
		preview_config = { border = "rounded" },
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation: ]h / [h jump between hunks, fall back to diff jumps in diff mode
			map("n", "]h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "]c", bang = true })
				else
					gs.nav_hunk("next")
				end
			end, "Next hunk")
			map("n", "[h", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end, "Prev hunk")

			-- Actions
			map("n", "<leader>gp", gs.preview_hunk_inline, "Preview hunk")
			map("n", "<leader>gh", gs.stage_hunk, "Stage/unstage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
			map("n", "<leader>gl", function()
				gs.blame_line({ full = true })
			end, "Blame line")

			-- Text object: vih / dih on a hunk
			map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
		end,
	},
}
