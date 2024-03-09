return {
  'b0o/incline.nvim',
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      hide = {
        cursorline = false,
        focused_win = false,
        only_win = true
      },
      window = {
        margin = {
          horizontal = 0,
          vertical = 1
        },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)

        return {
          { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
          { filename .. ' ',        gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        }
      end,
    }
  end,
  event = 'VeryLazy',
}
