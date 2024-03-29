return {
  "f-person/auto-dark-mode.nvim",
  config = function()
    local auto_dark_mode = require('auto-dark-mode')

    auto_dark_mode.setup({
      update_interval = 3000,
      set_dark_mode = function()
        vim.api.nvim_set_option('background', 'dark')
        vim.cmd('colorscheme tokyonight')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option('background', 'light')
        vim.cmd('colorscheme tokyonight-day')
      end,
    })
    auto_dark_mode.init()
  end
}
