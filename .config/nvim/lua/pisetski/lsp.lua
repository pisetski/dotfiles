local m = require('pisetski.mappings')
local servers = { "sumneko_lua", "tsserver", "bashls", "cssls", "gopls", "groovyls", "yamlls" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

local TSPrebuild = {}
local has_prebuilt = false

TSPrebuild.on_attach = function()
  if has_prebuilt then return end

  local query = require("vim.treesitter.query")

  local function safe_read(filename, read_quantifier)
    local file, err = io.open(filename, "r")
    if not file then error(err) end
    local content = file:read(read_quantifier)
    io.close(file)
    return content
  end

  local function read_query_files(filenames)
    local contents = {}

    for _, filename in ipairs(filenames) do table.insert(contents, safe_read(filename, "*a")) end

    return table.concat(contents, "")
  end

  local function prebuild_query(lang, query_name)
    local query_files = query.get_query_files(lang, query_name)
    local query_string = read_query_files(query_files)

    query.set_query(lang, query_name, query_string)
  end

  local prebuild_languages = { "typescript", "javascript", "tsx" }
  for _, lang in ipairs(prebuild_languages) do
    prebuild_query(lang, "highlights")
    prebuild_query(lang, "injections")
  end

  has_prebuilt = true
end

for _, lsp in ipairs(servers) do
  local config = {
    on_attach = function(client)
      if lsp == "tsserver" then
        client.resolved_capabilities.document_formatting = false
        TSPrebuild.on_attach()
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
