local m = require('pisetski.mappings')

require('trouble').setup({
  auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations", "lsp_type_definitions" }
})

m.mapTrouble()
