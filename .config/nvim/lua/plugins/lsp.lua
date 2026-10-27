return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"
    },
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    local servers = {
      "lua_ls",
      "bashls",
      "cssls",
      "yamlls",
      "eslint",
      "oxlint",
      "oxfmt",
      "jsonls",
      "marksman",
      "tsgo",
      "typos_lsp",
      "biome",
      "intelephense",
      "ltex_plus",
      "pylsp",
      "rust_analyzer"

    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = false,
    })

    -- Prevent LSP from overwriting the syntax highlighting
    vim.highlight.priorities.semantic_tokens = 95

    vim.lsp.inlay_hint.enable(false)

    vim.keymap.set('n', ',', vim.lsp.buf.code_action, { noremap = true, silent = true, })
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, { noremap = true, silent = true, })
    vim.keymap.set(
      'n',
      '<space>f',
      function()
        vim.lsp.buf.format {
          async = true,
          filter = function(client) return client.name ~= "tsgo" end
        }
      end,
      { noremap = true, silent = true, }
    )

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

    vim.lsp.config("lua_ls", {
      settings = {
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
    })

    local eslint_base_on_attach = vim.lsp.config.eslint.on_attach
    vim.lsp.config("eslint", {
      on_attach = function(client, bufnr)
        if not eslint_base_on_attach then return end

        eslint_base_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "LspEslintFixAll",
        })
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        local oxlint = vim.lsp.get_clients({ bufnr = args.buf, name = "oxlint" })[1]
        if oxlint then
          oxlint:request_sync("workspace/executeCommand", {
            command = "oxc.fixAll",
            arguments = { { uri = vim.uri_from_bufnr(args.buf) } },
          }, 3000, args.buf)
        end

        if #vim.lsp.get_clients({ bufnr = args.buf, name = "oxfmt" }) > 0 then
          vim.lsp.buf.format({ bufnr = args.buf, name = "oxfmt" })
        end
      end,
    })

    vim.lsp.config("ltex_plus", {
      settings = {
        ltex = {
          checkFrequency = "save",
          completionEnabled = false,
          additionalRules = {
            enablePickyRules = true,
          },
          enabled = { "markdown", "html" },
        }
      }
    })

    vim.lsp.config("pylsp", {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              maxLineLength = 100
            }
          }
        }
      }
    })

    vim.lsp.enable(servers)
  end
}
