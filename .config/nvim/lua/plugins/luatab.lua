return {
  'alvarosevilla95/luatab.nvim',
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    require('luatab').setup({
      separator = function() return '' end
    })
  end
}
