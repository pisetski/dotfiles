local lspconfig = require('lspconfig')
local null_ls = require('null-ls')

-- Register any number of sources simultaneously
local sources = {
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.diagnostics.eslint_d,
  null_ls.builtins.code_actions.eslint_d,
}

null_ls.setup({ sources = sources, root_dir = lspconfig.util.root_pattern('.git') })
