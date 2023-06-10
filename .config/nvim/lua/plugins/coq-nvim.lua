return {
  "ms-jpq/coq_nvim",
  branch = "coq",
  lazy = false,
  init = function()
    local map = require('pisetski.mappings')
    local kind_icons = {
      Text = '',
      Method = '',
      Function = '',
      Constructor = '',
      Field = '',
      Variable = '',
      Class = 'ﴯ',
      Interface = '',
      Module = '',
      Property = 'ﰠ',
      Unit = '',
      Value = '',
      Enum = '',
      Keyword = '',
      Snippet = '',
      Color = '',
      File = '',
      Reference = '',
      Folder = '',
      EnumMember = '',
      Constant = '',
      Struct = '',
      Event = '',
      Operator = '',
      TypeParameter = ''
    }

    vim.g.coq_settings = {
      clients = {
        tmux = {
          enabled = false,
        },
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
      },
      keymap = {
        pre_select = true,
        recommended = false,
        jump_to_mark = "<C-x>",
      }
    }

    map('i', '<Esc>', 'pumvisible() ? "\\<C-e><Esc>" : "\\<Esc>"', { expr = true })
    map('i', '<C-c>', 'pumvisible() ? "\\<C-e><C-c>" : "\\<C-c>"', { expr = true })

    map('i', '<Tab>', 'pumvisible() ? (complete_info().selected == -1 ? "\\<C-e><Tab>" : "\\<C-y>") : "\\<Tab>"',
      { expr = true })
  end
}
