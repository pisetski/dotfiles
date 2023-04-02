return {
  { "tpope/vim-surround" },
  { "folke/tokyonight.nvim" },

  -- Git
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

