return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"
    },
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

    -- Prevent LSP from overwriting the syntax highlighting
    vim.highlight.priorities.semantic_tokens = 95

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

    local augroup = vim.api.nvim_create_augroup('lsp', { clear = true })
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client.name == "eslint" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            command = "LspEslintFixAll",
          })
          return
        end

        if not client.name == "ts_ls" and client:supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
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

    vim.lsp.config("phpactor", {
      root_dir = function(startPath)
        local rp = (require 'lspconfig.util').root_pattern
        for _, pattern in pairs({ "index.php", "composer.json" })
        do
          local found = rp({ pattern })(startPath)
          if (found and found ~= '') then return found end
        end
        return nil
      end,
      init_options = {
        ["language_server_psalm.enabled"] = true,
        ["symfony.enabled"] = true,
        ["language_server_php_cs_fixer.enabled"] = true,
        ["phpunit.enabled"] = true
      }
    })

    vim.lsp.enable(servers)
  end
}
