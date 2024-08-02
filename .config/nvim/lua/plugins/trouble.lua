return {
  "folke/trouble.nvim",
  opts = {
    warn_no_results = false,
    auto_refresh = false,
    modes = {
      lsp_references = {
        params = {
          include_declaration = true,
        },
      },
    },
    keys = {
      j = "next",
      k = "prev",
    }
  },
  cmd = "Trouble",
  keys = {
    {
      "<space>w",
      "<cmd>Trouble diagnostics toggle focus=true auto_refresh=true auto_close=true<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<space>s",
      "<cmd>Trouble symbols toggle focus=true auto_refresh=true win.position=bottom<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "gr",
      "<cmd>Trouble lsp_references focus=true auto_jump=false win.position=bottom<cr>",
      desc = "LSP References",
    },
    {
      "gd",
      "<cmd>Trouble lsp_definitions focus=true auto_jump=true win.position=bottom<cr>",
      desc = "LSP Definitions",
    },
    {
      "gD",
      "<cmd>Trouble lsp_type_definitions focus=true auto_jump=true win.position=bottom<cr>",
      desc = "LSP Definitions",
    },
  },
}
