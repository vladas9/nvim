-- Highlight tweaks applied on top of the theme. Re-applied whenever the colorscheme changes.
local function apply_overrides()
	local c = require("gruvbox-baby.colors").config()
	local hl = function(name, val)
		vim.api.nvim_set_hl(0, name, val)
	end

	-- Completion menu windows
	hl("BlinkCmpMenu", { fg = c.foreground, bg = c.background_dark })
	hl("BlinkCmpMenuBorder", { fg = c.medium_gray, bg = c.background_dark })
	hl("BlinkCmpMenuSelection", { bg = c.medium_gray, bold = true })
	hl("BlinkCmpScrollBarThumb", { bg = c.comment })
	hl("BlinkCmpScrollBarGutter", { bg = c.background_dark })
	hl("BlinkCmpLabel", { fg = c.foreground })
	hl("BlinkCmpLabelMatch", { fg = c.soft_yellow, bold = true })
	hl("BlinkCmpLabelDescription", { fg = c.comment, italic = true })
	hl("BlinkCmpLabelDeprecated", { fg = c.comment, strikethrough = true })
	hl("BlinkCmpSource", { fg = c.comment, italic = true })
	hl("BlinkCmpDoc", { fg = c.foreground, bg = c.background_dark })
	hl("BlinkCmpDocBorder", { fg = c.medium_gray, bg = c.background_dark })
	hl("BlinkCmpDocSeparator", { fg = c.medium_gray, bg = c.background_dark })
	hl("BlinkCmpSignatureHelp", { fg = c.foreground, bg = c.background_dark })
	hl("BlinkCmpSignatureHelpBorder", { fg = c.medium_gray, bg = c.background_dark })
	hl("BlinkCmpSignatureHelpActiveParameter", { fg = c.soft_yellow, bold = true })

	-- Kind icons: one colour per category
	local kinds = {
		Text = c.foreground,
		Method = c.orange,
		Function = c.orange,
		Constructor = c.orange,
		Field = c.forest_green,
		Property = c.forest_green,
		EnumMember = c.forest_green,
		Variable = c.magenta,
		Constant = c.magenta,
		Reference = c.magenta,
		Value = c.magenta,
		Class = c.pink,
		Interface = c.pink,
		Struct = c.pink,
		Event = c.pink,
		Enum = c.pink,
		Unit = c.pink,
		Module = c.soft_yellow,
		Keyword = c.blue_gray,
		Operator = c.light_blue,
		TypeParameter = c.clean_green,
		Snippet = c.clean_green,
		Color = c.red,
		File = c.light_blue,
		Folder = c.light_blue,
	}
	-- File tree panel: darker background, no visible split line
	hl("NvimTreeNormal", { fg = c.foreground, bg = c.background_dark })
	hl("NvimTreeNormalNC", { fg = c.foreground, bg = c.background_dark })
	hl("NvimTreeEndOfBuffer", { fg = c.background_dark, bg = c.background_dark })
	hl("NvimTreeWinSeparator", { fg = c.background_dark, bg = c.background_dark })
	hl("NvimTreeCursorLine", { bg = c.background_light })
	hl("NvimTreeRootFolder", { fg = c.comment, italic = true })
	hl("NvimTreeFolderIcon", { fg = c.soft_yellow })
	hl("NvimTreeFolderName", { fg = c.foreground })
	hl("NvimTreeOpenedFolderName", { fg = c.soft_yellow, bold = true })
	hl("NvimTreeEmptyFolderName", { fg = c.comment })
	hl("NvimTreeIndentMarker", { fg = c.medium_gray })
	hl("NvimTreeSpecialFile", { fg = c.milk })
	hl("NvimTreeExecFile", { fg = c.forest_green })
	hl("NvimTreeSymlink", { fg = c.light_blue })
	hl("NvimTreeOpenedFile", { fg = c.milk, bold = true })
	hl("NvimTreeModifiedIcon", { fg = c.soft_yellow })
	hl("NvimTreeModifiedFile", { fg = c.soft_yellow })
	hl("NvimTreeGitDirtyIcon", { fg = c.soft_yellow })
	hl("NvimTreeGitStagedIcon", { fg = c.clean_green })
	hl("NvimTreeGitNewIcon", { fg = c.forest_green })
	hl("NvimTreeGitDeletedIcon", { fg = c.red })
	hl("NvimTreeGitRenamedIcon", { fg = c.magenta })
	hl("NvimTreeGitMergeIcon", { fg = c.orange })
	hl("NvimTreeGitIgnoredIcon", { fg = c.comment })
	hl("NvimTreeGitFileDirtyHL", { fg = c.soft_yellow })
	hl("NvimTreeGitFileStagedHL", { fg = c.clean_green })
	hl("NvimTreeGitFileNewHL", { fg = c.forest_green })
	hl("NvimTreeGitFileDeletedHL", { fg = c.red })
	hl("NvimTreeGitFileIgnoredHL", { fg = c.comment })
	hl("NvimTreeGitFolderDirtyHL", { fg = c.soft_yellow })
	hl("NvimTreeGitFolderNewHL", { fg = c.forest_green })

	-- Split lines between editor windows: subtle
	hl("WinSeparator", { fg = c.medium_gray })

	hl("BlinkCmpKind", { fg = c.dark_gray })
	for kind, color in pairs(kinds) do
		hl("BlinkCmpKind" .. kind, { fg = color })
	end
end

return {
	"luisiacc/gruvbox-baby",
	lazy = false, -- load at startup
	priority = 1000, -- before every other plugin
	config = function()
		vim.g.gruvbox_baby_background_color = "dark"
		vim.g.gruvbox_baby_telescope_theme = 1
		vim.cmd.colorscheme("gruvbox-baby")
		apply_overrides()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("user_hl_overrides", { clear = true }),
			callback = apply_overrides,
		})
	end,
}
