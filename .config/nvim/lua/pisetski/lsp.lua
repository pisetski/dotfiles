local m = require('pisetski.mappings')
local lsp_installer = require('nvim-lsp-installer')

-- Include the servers you want to have installed by default below
local servers = {
  'bashls',
  'eslint',
  'sumneko_lua',
  'tsserver',
  'marksman',
  'cssls',
  'gopls',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    server:install()
  end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- (sumneko/lua-language-servr)
-- Configure lua language server for neovim development
local lua_settings = {
  capabilities = capabilities,
  Lua = {
    runtime = {
      version = 'LuaJIT', -- LuaJIT in the case of Neovim
      path = vim.split(package.path, ';'),
    },
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

--Enable (broadcasting) snippet capability for completion
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cssls_settings = {
  capabilities = css_capabilities,
}


-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  m.mapLSP()
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local settings = {
    capabilities = capabilities,
  }

  if server.name == 'sumneko_lua' then
    settings = lua_settings
  end

  if server.name == 'cssls' then
    settings = cssls_settings
  end

  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup({
    settings = settings,
    on_attach = function(client)
      if (server.name == 'tsserver') then
        client.resolved_capabilities.document_formatting = false
      end

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
  })
end)

m.mapLSPDiagnostics()
