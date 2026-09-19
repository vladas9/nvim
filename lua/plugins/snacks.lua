return {
  "folke/snacks.nvim",
  priority = 900,
  lazy = false,
  opts = {
    -- Only the dashboard is enabled. Everything else in snacks stays off.
    dashboard = {
      preset = {
        header = table.concat({
          "███    ██ ██    ██ ██ ███    ███",
          "████   ██ ██    ██ ██ ████  ████",
          "██ ██  ██ ██    ██ ██ ██ ████ ██",
          "██  ██ ██  ██  ██  ██ ██  ██  ██",
          "██   ████   ████   ██ ██      ██",
        }, "\n"),
        keys = {
          { icon = "\u{f15b} ", key = "f", desc = "Find file", action = ":Telescope find_files" },
          { icon = "\u{f002} ", key = "g", desc = "Grep", action = ":Telescope live_grep" },
          { icon = "\u{f017} ", key = "r", desc = "Recent files", action = ":Telescope oldfiles" },
          { icon = "\u{e5ff} ", key = "e", desc = "Explorer", action = ":NvimTreeToggle" },
          { icon = "\u{f013} ", key = "c", desc = "Config", action = ":Telescope find_files cwd=" .. vim.fn.stdpath("config") },
          { icon = "\u{f1e6} ", key = "p", desc = "Plugins", action = ":Lazy" },
          { icon = "\u{f08b} ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "recent_files", icon = "\u{f017} ", title = "Recent", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    bigfile = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = { enabled = false },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
