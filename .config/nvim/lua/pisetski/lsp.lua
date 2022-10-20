local m = require('pisetski.mappings')
local servers = { "sumneko_lua", "tsserver", "bashls", "cssls", "gopls", "groovyls", "yamlls" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')
local on_attach = function()
  m.mapLSP()

  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      })
    end
  })
end

local lua_settings = {
  Lua = {
    diagnostics = {
      globals = { 'vim' }, -- Get the language server to recognize the `vim` global
    },
    workspace = { -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}


for _, lsp in ipairs(servers) do
  local config = {
    on_attach = function(client)
      if lsp == "tsserver" then
        client.resolved_capabilities.document_formatting = false
      end

      on_attach()
    end,
    capabilities = capabilities,
    settings = {},
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 300
    }
  }

  if lsp == "sumneko_lua" then
    config.settings = lua_settings
  end

  if lsp == "tsserver" then
    config.root_dir = require('lspconfig.util').find_git_ancestor
  end

  lspconfig[lsp].setup(config)
end
