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
        {
          'diagnostics',
          sources = { 'nvim_lsp' },
        },
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_workspace_diagnostic' },
        },
        'filetype',
        'progress'
      },
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
}
