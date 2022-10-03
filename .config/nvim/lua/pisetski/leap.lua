local leap = require('leap')

vim.api.nvim_set_hl(0, 'LeapBackdrop', { fg = nil })
leap.set_default_keymaps()
leap.setup({})
