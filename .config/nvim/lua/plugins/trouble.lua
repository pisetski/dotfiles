return {
  "folke/trouble.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    local m = require('pisetski.mappings')
    m.mapTrouble()

    return {
      auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations", "lsp_type_definitions" }
    }
  end
}
