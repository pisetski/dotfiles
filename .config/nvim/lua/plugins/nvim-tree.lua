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
  enabled = false,
  keys = {
    { '<Space>E', '<cmd>NvimTreeFindFile<cr>',       desc = "NvimTreeFindFile" },
    { '<Space>e', '<cmd>NvimTreeFindFileToggle<cr>', desc = "NvimTreeFindFileToggle" },
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = 'case_sensitive',
      view = {
        side = "right",
        adaptive_size = true,
        centralize_selection = true,
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
    })
  end
}
