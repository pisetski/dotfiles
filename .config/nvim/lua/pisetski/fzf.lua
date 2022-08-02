local m = require('pisetski.mappings')

require('fzf-lua').setup {
  winopts = {
    preview = { default = 'bat_native' }
  },
  files = {
    winopts = {
      width = 0.44,
      height = 0.44,
      preview = {
        hidden = 'hidden'
      }
    }
  },
  git = {
    branches = {
      winopts = {
        width = 0.44,
        height = 0.44,
        preview = {
          hidden = 'hidden'
        }
      }
    }
  },
  oldfiles = {
    cwd_only = true,
    winopts = {
      width = 0.44,
      height = 0.44,
      preview = {
        layout = 'vertical'
      }
    }
  },
  buffers = {
    cwd_only = true,
    winopts = {
      width = 0.44,
      height = 0.44,
      preview = {
        layout = 'vertical'
      }
    }
  },
}

m.mapFzf()
