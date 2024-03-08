require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  view = {
    side = 'right',
    width = 60
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        folder_arrow = true,
        folder = false
      },
      git_placement = 'after',
    },
    indent_markers = {
      enable = true
    }
  }
})

vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>')
