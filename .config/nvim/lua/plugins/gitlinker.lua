return {
  "ruifm/gitlinker.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<leader>L",
      "<cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
      desc = "Gitlinker repo"
    },
    {
      "<leader>l",
      desc = "Gitlinker line"
    },
  },
  config = function()
    require('gitlinker').setup({
      opts = {
        action_callback = require "gitlinker.actions".open_in_browser
      },
      mappings = "<leader>l"
    })
  end
}
