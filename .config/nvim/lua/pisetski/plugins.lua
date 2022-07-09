-- Bootstrap the package manager -- no need to install anything separately like
-- you have to do with vim-plug. Assumes that git is installed on the system
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.api.nvim_command 'packadd packer.nvim'
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use 'shaunsingh/nord.nvim'
  use 'tpope/vim-fugitive'
  use { -- Unified highlight for all filetypes
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
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
  use 'bryanmylee/vim-colorscheme-icons'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'styled-components/vim-styled-components'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'terrortylor/nvim-comment'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'tpope/vim-surround'
  use 'sickill/vim-pasta' -- Context aware pasting + indentation
  use 'windwp/nvim-autopairs'
  use {
    'ggandor/lightspeed.nvim',
    requires = { 'tpope/vim-repeat' } }
  use 'folke/which-key.nvim' -- Reminders of which key-bindings are available if getting stuck half-way through a binding
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }
  use 'lewis6991/impatient.nvim'
  use 'dstein64/vim-startuptime'
  use 'lewis6991/gitsigns.nvim'
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  }
  use 'rafamadriz/friendly-snippets'
  use 'windwp/nvim-ts-autotag'
  use 'antoinemadec/FixCursorHold.nvim' -- This is needed to fix lsp doc highlight
end)
