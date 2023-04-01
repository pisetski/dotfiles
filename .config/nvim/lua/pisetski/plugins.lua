local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "terrortylor/nvim-comment" },
  { "tpope/vim-surround" },
  { "windwp/nvim-autopairs" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" }
  },
  { "folke/which-key.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  { "folke/tokyonight.nvim" },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "kevinhwang91/nvim-hlslens" },
  "f-person/auto-dark-mode.nvim",

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
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "nvim-treesitter/nvim-treesitter-refactor" },
  { "p00f/nvim-ts-rainbow" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },

  -- Completion
  { "ms-jpq/coq_nvim", build = "python3 -m coq deps" },
  { "ms-jpq/coq.artifacts" },
  { "ms-jpq/coq.thirdparty" },

  -- LSP
  { "jose-elias-alvarez/null-ls.nvim" },
  { "MunifTanjim/eslint.nvim" },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"
  },
  {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  { "j-hui/fidget.nvim" }
})
