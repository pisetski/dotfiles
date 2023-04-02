return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    local m = require('pisetski.mappings')
    m.mapHlslens()

    require("hlslens").setup({
      nearest_only = true,
      calm_down = true
    })
  end
}
