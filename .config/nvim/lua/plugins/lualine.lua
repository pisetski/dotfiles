return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',
        disabled_filetypes = { "NvimTree" },
        always_divide_middle = true,
        globalstatus = false,
        component_separators = { left = '', right = '' },
        theme_options = { background = 'blue' }
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'branch',
            icon = "󰘬",
          },
          {
            'filetype',
            icon_only = true,
            padding = { left = 1, right = 0 }
          },
          {
            'filename',
            file_status = true,
            path = 1,
            padding = { left = 0, right = 1 }
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
          'progress'
        },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    })
  end
}
