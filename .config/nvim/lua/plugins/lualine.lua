return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      disabled_filetypes = { "NvimTree" },
      always_divide_middle = true,
      globalstatus = false,
      component_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        'branch',
        {
          'filename',
          file_status = true,
          path = 1,
        },
      },
      lualine_x = { 'diagnostics', 'filetype', 'progress' },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
}
