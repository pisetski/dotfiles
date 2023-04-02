return {
  "kevinhwang91/nvim-hlslens",
  keys = {
    "/",
    "?",
  },
  config = function()
    local map = require("pisetski.mappings")

    map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]])
    map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]])
    map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]])
    map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]])

    require("hlslens").setup({
      nearest_only = true,
      calm_down = true
    })
  end
}
