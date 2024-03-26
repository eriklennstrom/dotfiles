vim.cmd("set expandtab")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "
vim.opt.clipboard = 'unnamed'
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamed,unnamedplus"
vim.o.winbar = "%{%v:lua.require'utils.winbar'.eval()%}"
-- vim.cmd.colorscheme "tokyo-night"

vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

