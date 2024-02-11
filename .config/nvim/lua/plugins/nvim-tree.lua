return {
  "kyazdani42/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  cmd = {
    "NvimTreeFocus"
  },
  keys = {
    { '<Space>E', '<cmd>NvimTreeFindFile<cr>',       desc = "NvimTreeFindFile" },
    { '<Space>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = "NvimTreeFindFileToggle" },
  },
  config = function()
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.del('n', 's', { buffer = bufnr })
      vim.keymap.del('n', 'S', { buffer = bufnr })

      vim.keymap.set('n', 'A', api.tree.expand_all, opts('Expand All'))
      vim.keymap.set('n', 'Z', api.node.run.system, opts('Run System'))
    end

    require("nvim-tree").setup({
      sort_by = 'case_sensitive',
      view = {
        side = "right",
        adaptive_size = true,
        centralize_selection = true,
      },
      on_attach = on_attach,
      renderer = {
        group_empty = true,
        highlight_git = true,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = {
          '^\\.git'
        }
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      filesystem_watchers = {
        enable = true,
      },
      diagnostics = {
        enable = false
      },
    })
  end
}
