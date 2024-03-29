return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"
    },
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local servers = { "lua_ls", "tsserver", "bashls", "cssls", "gopls", "yamlls", "phpactor", "eslint" }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers
    })

    local function mapLSP(_, bufnr, lsp)
      local bufopts = { noremap = true, silent = true, buffer = bufnr }


      if lsp == "phpactor" then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      else
        vim.keymap.set('n', 'gd', '<cmd>Trouble lsp_definitions<cr>', bufopts)
      end

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set(
        'n',
        '<space>f',
        function()
          vim.lsp.buf.format {
            async = true,
            filter = function(client) return client.name ~= "tsserver" end
          }
        end,
        bufopts
      )
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    end

    local lspconfig = require('lspconfig')
    local on_attach = function(client, bufnr, lsp)
      mapLSP(client, bufnr, lsp)

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


    for _, lsp in ipairs(servers) do
      local config = {
        on_attach = function(client, bufnr)
          if lsp == "eslint" then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end

          on_attach(client, bufnr, lsp)
        end,
        settings = {},
        flags = {
          allow_incremental_sync = true,
          debounce_text_changes = 150
        }
      }

      if lsp == "lua_ls" then
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
        config.init_options = {
          ["language_server_psalm.enabled"] = true,
          ["symfony.enabled"] = true,
          ["language_server_php_cs_fixer.enabled"] = true,
          ["phpunit.enabled"] = true
        }
      end

      lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities(config))
    end
  end
}
