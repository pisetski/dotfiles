return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      disabled_filetypes = { "NvimTree" },
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'branch', 'diff',
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          colored = true,
          update_in_insert = false,
          always_visible = false,
        }
      },
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1,
        },
      },
      lualine_x = { 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
    tabline = {},
    extensions = {}
  }
}
