-- Bootstrap the package manager
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'terrortylor/nvim-comment'
  use 'tpope/vim-surround'
  use 'sickill/vim-pasta'
  use 'windwp/nvim-autopairs'
  use {
    'ggandor/lightspeed.nvim',
    requires = { 'tpope/vim-repeat' } }
  use 'folke/which-key.nvim'
  use 'lewis6991/impatient.nvim'
  use 'dstein64/vim-startuptime'
  use 'windwp/nvim-ts-autotag'
  use 'shaunsingh/nord.nvim'
  use 'bryanmylee/vim-colorscheme-icons'
  use 'styled-components/vim-styled-components'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim', -- Utility functions for Lua. Direct dependency
      'nvim-treesitter/nvim-treesitter' -- Optional dependency
    }
  }
  use 'AckslD/nvim-neoclip.lua' -- Telescope yanks search
  use 'nvim-telescope/telescope-ui-select.nvim' -- Neovim core stuff with Telescope picker
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Completion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'antoinemadec/FixCursorHold.nvim'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
end)
