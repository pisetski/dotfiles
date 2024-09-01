return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    local function create_codecompanion_component()
      local M = require("lualine.component"):extend()
      M.processing = false
      M.spinner_index = 1
      local spinner_symbols = {
        "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏",
      }
      local spinner_symbols_len = 10

      function M:init(options)
        M.super.init(self, options)
        local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequest*",
          group = group,
          callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
          end,
        })
      end

      function M:update_status()
        if self.processing then
          self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
          return spinner_symbols[self.spinner_index]
        else
          return nil
        end
      end

      return M
    end

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
          create_codecompanion_component(),
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
