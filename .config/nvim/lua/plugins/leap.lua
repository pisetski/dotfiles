return {
  "ggandor/leap.nvim",
  lazy = false,
  keys = {
    { "s", desc = "Leap forward" },
    { "S", desc = "Leap backward" }
  },
  dependencies = { "tpope/vim-repeat" },
  init = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = nil })
      end
    })
  end,
  config = function()
    local leap = require('leap')
    leap.add_default_mappings()
  end
}

