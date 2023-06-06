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
  },
  'sindrets/diffview.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
}
