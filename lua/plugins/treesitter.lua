-- Languages that get parsers installed. Add more here as needed.
local languages = {
	"lua",
	"vim",
	"vimdoc",
	"query",
	"go",
	"gomod",
	"gosum",
	"python",
	"javascript",
	"typescript",
	"tsx",
	"jsdoc",
	"html",
	"css",
	"json",
	"yaml",
	"toml",
	"sql",
	"bash",
	"markdown",
	"markdown_inline",
	"regex",
	"gitcommit",
	"diff",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(languages)

			-- Start highlighting, folding and indentation whenever a parser exists
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
				callback = function(ev)
					local ok = pcall(vim.treesitter.start, ev.buf)
					if ok then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
						vim.wo.foldmethod = "expr"
						vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo.foldlevel = 99 -- everything open by default
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select").select_textobject
			local move = require("nvim-treesitter-textobjects.move")
			local map = vim.keymap.set

			-- Select: vaf / vif = function, vaa / via = argument
			for key, obj in pairs({ f = "function", a = "parameter" }) do
				map({ "x", "o" }, "a" .. key, function()
					select("@" .. obj .. ".outer", "textobjects")
				end, { desc = "around " .. obj })
				map({ "x", "o" }, "i" .. key, function()
					select("@" .. obj .. ".inner", "textobjects")
				end, { desc = "inside " .. obj })
			end

			-- Move: ]f / [f next/prev function
			map({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end, { desc = "Next function" })
			map({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end, { desc = "Prev function" })
		end,
	},
}
