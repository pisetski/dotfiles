local m = require('pisetski.mappings')
local telescope = require('telescope')
local actions = require('telescope.actions')
local neoclip = require('neoclip')

telescope.setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
      },
    },
    -- The below pattern is lua regex and not wildcard
    file_ignore_patterns = { "node_modules", "%.out" },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    find_files = {
      theme = 'dropdown',
      layout_strategy = 'center',
      previewer = false
    },
    buffers = {
      theme = 'ivy'
    },
    oldfiles = {
      theme = 'ivy'
    },
    marks = {
      theme = 'ivy'
    },
    git_branches = {
      theme = 'dropdown',
      layout_strategy = 'center',
      previewer = false
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

neoclip.setup({
  history = 50,
  keys = {
    telescope = {
      i = {
        paste = '<cr>',
      },
      n = {
        paste = '<cr>',
      },
    },
  },
})
telescope.load_extension('neoclip')

m.mapTelescope()
