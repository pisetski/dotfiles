return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"
    },
    "williamboman/mason-lspconfig.nvim",
    "pmizio/typescript-tools.nvim",
  },
  config = function()
    local servers = {
      "lua_ls",
      "bashls",
      "cssls",
      "gopls",
      "yamlls",
      "phpactor",
      "eslint",
      "jsonls",
      "marksman",
      "ts_ls",
      "typos_lsp",
      "biome"
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })

    -- Prevent LSP from overwriting the syntax highlighting
    vim.highlight.priorities.semantic_tokens = 95

    local function set_mappings(_, bufnr)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set('n', ',', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set(
        'n',
        '<space>f',
        function()
          vim.lsp.buf.format {
            async = true,
            filter = function(client) return client.name ~= "ts_ls" end
          }
        end,
        bufopts
      )
      vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
    end

    local on_attach_custom = function(client, bufnr)
      set_mappings(client, bufnr)

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

    local lspconfig = require('lspconfig')

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    for _, lsp in ipairs(servers) do
      local config = {
        on_attach = function(client, bufnr)
          if lsp == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
            return
          end

          if lsp ~= "ts_ls" and client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end

          on_attach_custom(client, bufnr)
        end,
        settings = {},
        flags = {
          allow_incremental_sync = true,
          debounce_text_changes = 150
        }
      }

      if lsp == "lua_ls" then
        config.settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
              }
            }
          }
        }
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
        config.init_options = {
          ["language_server_psalm.enabled"] = true,
          ["symfony.enabled"] = true,
          ["language_server_php_cs_fixer.enabled"] = true,
          ["phpunit.enabled"] = true
        }
      end

      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[lsp].setup(config)
    end
  end
}
