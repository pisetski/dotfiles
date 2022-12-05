local m = require('pisetski.mappings')

require('nvim-tree').setup {
  sort_by = 'case_sensitive',
  open_on_setup = false,
  view = {
    adaptive_size = true,
    centralize_selection = true,
    mappings = {
      list = {
        -- { key = 'u', action = 'dir_up' },
      },
    },
  },
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
}

m.mapNvimTree()
