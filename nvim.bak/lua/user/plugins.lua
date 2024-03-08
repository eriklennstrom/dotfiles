local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
   open_fn = function()
     return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use
use({
  "neanias/everforest-nvim",
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({
      background = "hard",
      transparent_background_level = 1
    })
    require("everforest").load()
  end,
})

use('fatih/vim-go')

-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('user/plugins/telescope')
  end
})
-- A Status line.
  use({
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/lualine')
    end
  })

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
  end,
})

-- Packaer can manage itself
use('wbthomason/packer.nvim')

-- Commenting support
use('tpope/vim-commentary')

-- Automatically set the working directory to the project root
use({
  'airblade/vim-rooter',
  setup = function()
    -- Instead of this running every time we open a file, just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
  end,
  -- config = function()
  --   vim.cmd('Rooter')
  -- end
})

-- Text objects for HTML attributes.
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

use('christoomey/vim-tmux-navigator')
use('farmergreg/vim-lastplace')
use('tpope/vim-repeat')
use('tpope/vim-surround')
use('tpope/vim-eunuch') -- Adds :Rename, :SudoWrite
use('tpope/vim-unimpaired') -- Adds [b and other handy mappings
use('tpope/vim-sleuth') -- Indent autodetection with editorconfig support
use('jessarcher/vim-heritage') -- Automatically create parent dirs when saving
use('nelstrom/vim-visual-star-search')

-- Automatically fix indentation when pasting.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- All closing buffers without closing the split window
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})
-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
  end,
})
-- Automatically add closing brackets, quotes, etc.
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Git integration
use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
    vim.keymap.set('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })
    vim.keymap.set('n', 'gs',  ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', 'gS',  ':Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', 'gp',  ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb',  ':Gitsigns blame_line<CR>')
  end,
})

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('user/plugins/treesitter')
  end,
})
-- Language Server Protocol
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('user/plugins/lspconfig')
  end
})

-- Autocompletion
use {
  "hrsh7th/nvim-cmp",
  requires = {
    "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
    'hrsh7th/cmp-nvim-lua', 'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip',
    'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
    'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
  },
  config = function()
    require('user/plugins/completion')
  end
}

-- Vim Wiki
use {
  'vimwiki/vimwiki',
  config = function()
    vim.g.vimwiki_list = {
      {
        path = '/home/e18m/code/eriklennstrom/notes',
        ext = '.md',
      }
    }
  end
}

-- Vim Wiki
use('michal-h21/vimwiki-sync')

-- Installation
-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])


