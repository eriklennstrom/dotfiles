return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end
}
--require("catppuccin").setup({
  -- transparent_background = true,
--})
