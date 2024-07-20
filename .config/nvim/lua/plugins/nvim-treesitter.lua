return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  version = "*",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
    { "nvim-treesitter/nvim-treesitter-refactor" },
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      -- A list of parser names, or 'all'
      ensure_installed = {
        'css',
        'lua',
        'dockerfile',
        'dot',
        'html',
        'javascript',
        'json',
        'make',
        'markdown',
        'regex',
        'tsx',
        'typescript',
        'yaml',
        'gitignore',
        'bash',
        'go',
        'php',
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      -- List of parsers to ignore installing (for 'all')
      ignore_install = {},
      highlight = {
        -- `false` will disable the whole extension
        enable = true,
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false
      },
      refactor = {
        highlight_definitions = {
          enable = true,
          -- Set to false if you have an `updatetime` of ~100.
          clear_on_cursor_move = true,
        },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-n>',
          node_incremental = '<C-j>',
          scope_incremental = false,
          node_decremental = '<C-k>',
        },
      },
    })

    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = false
      },
    })
  end
}
