return {
  "f-person/auto-dark-mode.nvim",
  config = {
    update_interval = 1000,
    set_dark_mode = function()
      vim.api.nvim_set_option("background", "dark")
      vim.cmd("colorscheme tokyonight")
      vim.env.BAT_THEME = "tokyonight_storm"
    end,
    set_light_mode = function()
      vim.api.nvim_set_option("background", "light")
      vim.cmd("colorscheme tokyonight-day")
      vim.env.BAT_THEME = "tokyonight_day"
    end,
  },
}
