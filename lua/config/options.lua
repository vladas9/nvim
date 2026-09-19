-- netrw off: nvim-tree replaces it
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes" -- fixed width, no text shifting when signs appear
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.termguicolors = true
opt.showmode = false -- lualine shows the mode
opt.showtabline = 0
opt.laststatus = 3 -- single global statusline
opt.cmdheight = 0 -- hide the command line until : is pressed
opt.shortmess:append("WcCI") -- no "written" message, no completion noise, no intro
opt.splitright = true
opt.splitbelow = true
opt.pumheight = 10
opt.fillchars = { eob = " " } -- no ~ on empty lines

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.clipboard = "unnamedplus" -- system clipboard
opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.confirm = true -- ask instead of failing on :q with unsaved changes
opt.autoread = true -- reload files changed outside nvim (e.g. by Claude); see checktime autocmd
opt.virtualedit = "block"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live preview for :s

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
