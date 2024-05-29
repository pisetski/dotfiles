return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  lazy = false,
  init = function()
    local map = require('pisetski.mappings')
    local kind_icons = {
      Boolean = "",
      Character = "󱌯",
      Class = "",
      Color = "",
      Constant = "",
      Constructor = "",
      Enum = "",
      EnumMember = "",
      Event = "",
      Field = "",
      File = "󰈔",
      Folder = "",
      Function = "󰊕",
      Interface = "",
      Keyword = "",
      Method = "",
      Module = "󰕳",
      Number = "",
      Operator = "Ψ",
      Parameter = "󰘦",
      Property = "",
      Reference = "",
      Snippet = "",
      String = "󰅳",
      Struct = "",
      Text = "",
      TypeParameter = "",
      Unit = "",
      Value = "",
      Variable = "󰫧",
    }

    vim.g.coq_settings = {
      clients = {
        tmux = {
          enabled = false,
        },
        lsp = {
          always_on_top = {},
        }
      },
      auto_start = 'shut-up',
      display = {
        pum = {
          fast_close = true,
          source_context = { "", "" },
          kind_context = { "  ", "" },
        },
        icons = {
          mappings = kind_icons,
          mode = "short"
        },
        ghost_text = {
          enabled = false,
        },
        mark_applied_notify = false,
        preview = {
          border = "solid"
        },
      },
      limits = {
        completion_auto_timeout = 0.3,
        completion_manual_timeout = 1,
      },
      keymap = {
        pre_select = true,
        recommended = false,
        jump_to_mark = '<C-x>',
      },
      match = {
        max_results = 9
      }
    }

    map('i', '<Esc>', 'pumvisible() ? "\\<C-e><Esc>" : "\\<Esc>"', { expr = true })
    map('i', '<C-c>', 'pumvisible() ? "\\<C-e><C-c>" : "\\<C-c>"', { expr = true })

    map('i', '<Tab>', 'pumvisible() ? (complete_info().selected == -1 ? "\\<C-e><Tab>" : "\\<C-y>") : "\\<Tab>"',
      { expr = true })
  end
}
