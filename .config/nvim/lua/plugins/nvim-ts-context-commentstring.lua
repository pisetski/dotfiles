return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  config = function()
    require('ts_context_commentstring').setup {
      enable_autocmd = false,
    }

    local prev_get_option = vim.filetype.get_option
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.filetype.get_option = function(filetype, option)
      return option == "commentstring"
          and require("ts_context_commentstring.internal").calculate_commentstring()
          or prev_get_option(filetype, option)
    end
  end
}
