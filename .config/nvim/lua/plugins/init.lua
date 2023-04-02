return {
  { "terrortylor/nvim-comment" },
  { "tpope/vim-surround" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" }
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  { "folke/tokyonight.nvim" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "kevinhwang91/nvim-hlslens" },

  -- Git
  { "lewis6991/gitsigns.nvim" },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
  { "kdheepak/lazygit.nvim" },
  -- Packer
  { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter-refactor" },
  { "p00f/nvim-ts-rainbow" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- Completion
  { "ms-jpq/coq_nvim", build = "python3 -m coq deps" },
  { "ms-jpq/coq.artifacts" },
  { "ms-jpq/coq.thirdparty" },

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  { "j-hui/fidget.nvim" }
}

