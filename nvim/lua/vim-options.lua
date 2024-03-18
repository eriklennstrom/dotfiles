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
