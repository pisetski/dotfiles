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
      "jsonls",
      "marksman",
      "ts_ls",
      "typos_lsp",
      "biome",
      "intelephense",
      "ltex_plus",
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = false,
    })

    -- Prevent LSP from overwriting the syntax highlighting
    vim.highlight.priorities.semantic_tokens = 95

    -- Enable inlay hints globally
    vim.lsp.inlay_hint.enable(true)

    vim.keymap.set('n', ',', vim.lsp.buf.code_action, { noremap = true, silent = true, })
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, { noremap = true, silent = true, })
    vim.keymap.set(
      'n',
      '<space>f',
      function()
        vim.lsp.buf.format {
          async = true,
          filter = function(client) return client.name ~= "ts_ls" end
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

    vim.lsp.enable(servers)
  end
}
