require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "help" ,"vue", "typescript" },

  auto_install = true,
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
    disable = { "c", "rust" },
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true
  }
})
