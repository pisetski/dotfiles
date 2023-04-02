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
  { "kevinhwang91/nvim-hlslens" },

  -- Git
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

  -- LSP
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
}

