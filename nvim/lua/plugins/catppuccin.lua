return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  options = {
	transparent_background = true
  },
  config = function()
	vim.cmd.colorscheme "catppuccin"
	local catppuccin = require("catppuccin")
  end
}
--require("catppuccin").setup({
  -- transparent_background = true,
--})
