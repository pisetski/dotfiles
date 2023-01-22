-- Bootstrap the package manager
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  vim.api.nvim_command({"packadd packer.nvim"})
end

return require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "terrortylor/nvim-comment"
  use "tpope/vim-surround"
  use "windwp/nvim-autopairs"
  use {
    "ggandor/leap.nvim",
    requires = { "tpope/vim-repeat" }
  }
  use "folke/which-key.nvim"
  use "lewis6991/impatient.nvim"
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" }
  }
  use { "ibhagwan/fzf-lua",
    requires = { "kyazdani42/nvim-web-devicons" }
  }
  use {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
  }
  use "folke/tokyonight.nvim"
  use { "akinsho/toggleterm.nvim", tag = "*" }
  use "lukas-reineke/indent-blankline.nvim"
  use "kevinhwang91/nvim-hlslens"

  -- Git
  use { "lewis6991/gitsigns.nvim" }
  use {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
  }
  use "kdheepak/lazygit.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "nvim-treesitter/nvim-treesitter-refactor"
  use "p00f/nvim-ts-rainbow"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Completion
  use { "ms-jpq/coq_nvim", run = "python3 -m coq deps" }
  use "ms-jpq/coq.artifacts"
  use "ms-jpq/coq.thirdparty"

  -- LSP
  use "jose-elias-alvarez/null-ls.nvim"
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use "j-hui/fidget.nvim"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
end)
