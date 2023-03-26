local npairs = require('nvim-autopairs')
local remap = vim.api.nvim_set_keymap

npairs.setup({
  check_ts = true,
  enable_check_bracket_line = true,
  disable_filetype = { "TelescopePrompt" },
  map_bs = false,
  map_cr = false,
})

_G.MUtils = {}

MUtils.Tab = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<Tab>', 'v:lua.MUtils.Tab()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
