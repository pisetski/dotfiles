return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  cmd = {
    "NvimTreeFocus"
  },
  keys = {
    { '<leader>E', '<cmd>NvimTreeFindFile<cr>', desc = "NvimTreeFindFile" },
    { '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = "NvimTreeFindFileToggle" },
  },
  opts = {
    sort_by = 'case_sensitive',
    open_on_setup = false,
    view = {
      side = "right",
      adaptive_size = true,
      centralize_selection = true,
      mappings = {
        list = {
          { key = 's', action = '' },
          { key = 'S', action = '' },
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
}

