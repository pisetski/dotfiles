return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
  },
  lazy = false,
  branch = "main",
  init = function()
    local ensureInstalled = {
      'lua',
      'typescript',
      'css',
      'dockerfile',
      'dot',
      'html',
      'javascript',
      'make',
      'markdown',
      'regex',
      'tsx',
      'yaml',
      'gitignore',
      'bash',
      'go',
      'php'
    }

    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensureInstalled,
      callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        vim.treesitter.start()
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
      },
    })
  end
}
