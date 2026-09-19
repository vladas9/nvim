local aug = function(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  group = aug("highlight_yank"),
  callback = function() vim.hl.on_yank({ timeout = 150 }) end,
})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = aug("restore_cursor"),
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with q
vim.api.nvim_create_autocmd("FileType", {
  group = aug("close_with_q"),
  pattern = { "help", "qf", "man", "checkhealth", "lspinfo", "notify" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

-- Language-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  group = aug("indent"),
  pattern = { "go", "python" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    if vim.bo.filetype == "go" then vim.opt_local.expandtab = false end
  end,
})

-- Reload files changed outside nvim (e.g. edited by Claude in the terminal split).
-- autoread only checks timestamps on a few events, so trigger checktime ourselves.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave", "TermClose" }, {
  group = aug("autoread"),
  callback = function()
    -- checktime is a no-op while an autocmd is running, so defer it
    vim.schedule(function()
      if vim.fn.getcmdwintype() == "" and vim.fn.mode() ~= "c" then
        vim.cmd("silent! checktime")
      end
    end)
  end,
})

-- Tell the user when a buffer was reloaded from disk
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = aug("autoread_notify"),
  callback = function(ev)
    vim.notify("Reloaded " .. vim.fn.fnamemodify(ev.file, ":~:."), vim.log.levels.INFO)
  end,
})
