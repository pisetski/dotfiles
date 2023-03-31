local m = require('pisetski.mappings')
local servers = { "lua_ls", "tsserver", "bashls", "cssls", "gopls", "groovyls", "yamlls", "phpactor" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers
})

local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  m.mapLSP(client, bufnr)
  m.mapLSPDiagnostics()

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
    on_attach = function(client, bufnr)
      if lsp == "tsserver" then
        client.server_capabilities.document_formatting = false
      end

      on_attach(client, bufnr)
    end,
    settings = {},
    flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 150
    }
  }

  if lsp == "sumneko_lua" then
    config.settings = lua_settings
  end

  if lsp == "tsserver" then
    config.root_dir = require('lspconfig.util').find_git_ancestor
  end

  if lsp == "phpactor" then
    config.root_dir = function(startPath)
      local rp = (require 'lspconfig.util').root_pattern
      for _, pattern in pairs({ "index.php", "composer.json" })
      do
        local found = rp({ pattern })(startPath)
        if (found and found ~= '') then return found end
      end
      return nil
    end
  end

  lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities(config))
end
