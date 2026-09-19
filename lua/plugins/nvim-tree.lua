return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  },
  init = function()
    -- Open the tree instead of netrw when starting nvim on a directory
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("user_nvim_tree_dir", { clear = true }),
      callback = function(ev)
        if vim.fn.isdirectory(ev.file) == 1 then
          vim.cmd.cd(ev.file)
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
  opts = {
    hijack_cursor = true,           -- keep the cursor on the file name, not column 0
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = { enable = true }, -- highlight the current buffer's file
    view = {
      width = 34,
      side = "left",
      signcolumn = "yes",
      cursorline = true,
    },
    modified = { enable = true }, -- mark buffers with unsaved changes
    renderer = {
      root_folder_label = function(path) return "  " .. vim.fn.fnamemodify(path, ":t") end,
      highlight_git = "name",            -- colour file names by git status
      highlight_modified = "name",
      highlight_opened_files = "name",
      indent_width = 2,
      indent_markers = {
        enable = true,
        icons = { corner = "\u{2514}", edge = "\u{2502}", item = "\u{2502}", bottom = "\u{2500}", none = " " },
      },
      icons = {
        git_placement = "right_align",  -- markers in a tidy column on the right
        modified_placement = "right_align",
        diagnostics_placement = "signcolumn",
        padding = " ",
        show = { folder_arrow = false, modified = true },
        glyphs = {
          default = "\u{f15b}",
          symlink = "\u{f481}",
          folder = {
            default = "\u{e5ff}",
            open = "\u{e5fe}",
            empty = "\u{f114}",
            empty_open = "\u{f115}",
            symlink = "\u{f482}",
            symlink_open = "\u{f482}",
          },
          modified = "\u{25cf}",
          git = {
            unstaged = "\u{25cf}",  -- small dot
            staged = "\u{f00c}",    -- check
            unmerged = "\u{e727}",
            renamed = "\u{f101}",   -- »
            untracked = "\u{f128}", -- ?
            deleted = "\u{f00d}",   -- ✗
            ignored = "\u{f070}",
          },
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { [[^\.git$]], [[^node_modules$]], [[^\.DS_Store$]] }, -- vim regex
    },
    git = { enable = true, ignore = false },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = { hint = "\u{f0eb}", info = "\u{f05a}", warning = "\u{f071}", error = "\u{f057}" },
    },
    actions = {
      open_file = {
        quit_on_open = false,
        window_picker = { enable = false }, -- open in the last used window
      },
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      api.config.mappings.default_on_attach(bufnr) -- keep all defaults
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = "nvim-tree: " .. desc })
      end
      map("l", api.node.open.edit, "Open")
      map("h", api.node.navigate.parent_close, "Close folder")
      map("H", api.tree.collapse_all, "Collapse all")
      map("?", api.tree.toggle_help, "Help")
      map("<C-h>", "<cmd>TmuxNavigateLeft<cr>", "Window left")   -- keep tmux navigation working
      map("<C-l>", "<cmd>TmuxNavigateRight<cr>", "Window right")
    end,
  },
}
