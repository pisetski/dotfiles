local m = require('pisetski.mappings')

require('gitlinker').setup({
  opts = {
    action_callback = require"gitlinker.actions".open_in_browser
  },
  mappings = "<leader>v"
})

m.mapGitlinker()
