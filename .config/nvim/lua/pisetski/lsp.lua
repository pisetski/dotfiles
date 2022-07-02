local m = require("pisetski.mappings")
local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
  "bashls",
  "eslint",
  "sumneko_lua",
  "tsserver",
  "marksman",
  "cssls",
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
  settings = {
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
}

--Enable (broadcasting) snippet capability for completion
local css_capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local cssls_settings = {
  settings = {
    capabilities = css_capabilities,
  }
}

local tssserver_settings = {
  settings = {
    capabilities = capabilities,
  },
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
}

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  m.mapLSP()
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = {
    settings = {
      capabilities = capabilities,
    },
  }

  if server.name == "sumneko_lua" then
    opts = lua_settings
  end

  if server.name == "cssls" then
    opts = cssls_settings
  end

  if server.name == "tsserver" then opts = tssserver_settings
  end

  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)

m.mapLSPDiagnostics()
