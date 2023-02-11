local m = require('pisetski.mappings')

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

m.mapCOQ()
