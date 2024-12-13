return {
  'christoomey/vim-tmux-navigator',
  -- vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>'),
  -- vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>'),
  -- vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>'),
  -- vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>'),
  vim.keymap.set('n', 'C-Left', ':TmuxNavigateLeft<CR>'),
  vim.keymap.set('n', 'C-Down', ':TmuxNavigateDown<CR>'),
  vim.keymap.set('n', 'C-Up', ':TmuxNavigateUp<CR>'),
  vim.keymap.set('n', 'C-Right', ':TmuxNavigateRight<CR>')
}
