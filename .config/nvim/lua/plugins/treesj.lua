return {
  'Wansmer/treesj',
  keys = { '<space>m' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('treesj').setup({
      use_default_keymaps = false,
      max_join_length = 300,
    })
    vim.keymap.set('n', '<space>m', require('treesj').toggle)
  end,
}
