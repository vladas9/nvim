return {
	{
		"saghen/blink.cmp",
		version = "1.*", -- prebuilt fuzzy-matcher binary, no Rust toolchain needed
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "\u{f100}",
					Method = "\u{f6a6}",
					Function = "\u{f0295}",
					Constructor = "\u{f423}",
					Field = "\u{f0e8}",
					Variable = "\u{f0ae7}",
					Property = "\u{f0ad}",
					Class = "\u{f0e8}",
					Interface = "\u{f0e8}",
					Struct = "\u{f0e8}",
					Module = "\u{f487}",
					Unit = "\u{f0e8}",
					Value = "\u{f0a4}",
					Enum = "\u{f15d}",
					EnumMember = "\u{f15d}",
					Keyword = "\u{f1de}",
					Constant = "\u{f8fe}",
					Snippet = "\u{f0c4}",
					Color = "\u{e22b}",
					File = "\u{f15b}",
					Reference = "\u{f0c1}",
					Folder = "\u{f07b}",
					Event = "\u{f0e7}",
					Operator = "\u{f0c8}",
					TypeParameter = "\u{f0e8}",
				},
			},
			completion = {
				list = { selection = { preselect = false, auto_insert = false } }, -- nothing chosen until you Tab
				menu = {
					border = "rounded",
					draw = {
						treesitter = { "lsp" }, -- colour labels like code
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
							{ "source_name" },
						},
						components = {
							source_name = {
								text = function(ctx)
									local names = {
										lsp = "LSP",
										path = "Path",
										snippets = "Snip",
										buffer = "Buf",
										lazydev = "Lua",
									}
									return names[ctx.source_id] or ctx.source_name
								end,
								highlight = "BlinkCmpSource",
							},
						},
					},
				},
				documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
				ghost_text = { enabled = false },
			},
			signature = { enabled = true, window = { border = "rounded" } },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
				},
			},
			cmdline = {
				keymap = { preset = "cmdline" },
				completion = { menu = { auto_show = true } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
