return {
  {
--      https://stackoverflow.com/a/78983676
--      If you're using the LazyVim plugin manager for Neovim, follow these steps:
--      Open LazyVim by typing :Lazy.
--      Use the up/down arrow keys to highlight telescope-fzf-native.nvim and press Enter.
--      Then, press the keys g followed by b (i.e., gb) in succession to start compiling the libfzf.so library file that is missing. The task will appear briefly in the :Lazy window.
--      Exit the LazyVim window with :q.
--      Finally, reopen nvim.
--      This should fix the issue.
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      require('telescope').load_extension('fzf')
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
      vim.keymap.set('n', '<leader> ', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>v', builtin.diagnostics, {})
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  },
}
