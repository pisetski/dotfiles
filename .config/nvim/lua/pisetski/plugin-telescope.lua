local m = require('pisetski.mappings')
local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ['<esc>'] = actions.close
      },
    },
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
    git_branches = {
      theme = 'dropdown',
      layout_strategy = 'center',
      previewer = false
    },
  },  
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

require('telescope').load_extension('fzf')
m.mapTelescope()
