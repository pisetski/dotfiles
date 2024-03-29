return {
  "folke/trouble.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = function()
    local map = require('pisetski.mappings')

    map('n', '<leader>xx', '<cmd>Trouble<cr>')
    map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>')
    map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
    map('n', 'gr', '<cmd>Trouble lsp_references<cr>')
    map('n', 'gd', '<cmd>Trouble lsp_definitions<cr>')
    map('n', '<space>D', '<cmd>Trouble lsp_type_definitions<cr>')

    return {
      auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations", "lsp_type_definitions" }
    }
  end
}
