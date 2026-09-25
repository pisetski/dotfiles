return {
  cmd = {
    "DiffviewFileHistory",
    "DiffviewOpen",
  },
  keys = {
    {
      "<leader>d",
      ":DiffviewFileHistory %<CR>",
      desc = "Diffview File History of the current buffer"
    },
    {
      "<leader>D",
      ":DiffviewOpen<CR>",
      desc = "Diffview uncommitted changes"
    },
  },
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
}
