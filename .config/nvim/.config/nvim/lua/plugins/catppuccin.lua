return {
  {
    "catppuccin",
    lazy = false,
    opts = {
      transparent_background = true,
      color_overrides = {
        all = {
          text = "#ffffff",
        },
        latte = {
          base = "#ff0000",
          mantle = "#242424",
          crust = "#474747",
        },
        frappe = {},
        macchiato = {},
        mocha = {},
      },
    },
    config = function()
      require("catppuccin").setup({
        transparent_background = true, -- disables setting the background color.
        -- highlight_overrides = {
        --   all = function(colors)
        --     return {
        --       LineNr = { fg = #000 },
        --     }
        --   end,
        -- },
      })
      vim.cmd.colorscheme("catppuccin")
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#a0a0a0" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#3B4252", fg = "#5E81AC" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#3B4252" })
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#3B4252" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#3B4252" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
