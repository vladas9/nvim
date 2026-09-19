return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    -- Names of every LSP client attached to the current buffer
    local function lsp_clients()
      local names = {}
      for _, c in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        names[#names + 1] = c.name
      end
      return #names > 0 and "\u{f085} " .. table.concat(names, ", ") or ""
    end

    -- Show a marker when format-on-save is disabled
    local function format_off()
      return (vim.g.disable_autoformat or vim.b.disable_autoformat) and "\u{f0c7} off" or ""
    end

    return {
      options = {
        theme = "gruvbox-baby",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "\u{e0b4}", right = "\u{e0b6}" },
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { { "mode", fmt = function(s) return s:sub(1, 1) end } }, -- N / I / V
        lualine_b = { { "branch", icon = "\u{e725}" } },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "\u{25cf}", readonly = "\u{f023}", unnamed = "[No Name]" } },
          {
            "diagnostics",
            symbols = { error = "\u{f057} ", warn = "\u{f071} ", info = "\u{f05a} ", hint = "\u{f0eb} " },
          },
        },
        lualine_x = {
          { format_off, color = { fg = "#fb4934" } },
          { "diff", symbols = { added = "+", modified = "~", removed = "-" } },
          { lsp_clients },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "nvim-tree", "lazy", "mason", "quickfix", "toggleterm" },
    }
  end,
}
