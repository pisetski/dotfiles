return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = 'v1.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  -- Install prebuilt binaries for rust fuzzy implementation: https://cmp.saghen.dev/configuration/fuzzy#prebuilt-binaries-default-on-a-release-tag

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap. when defining your own, no keybinds will be assigned automatically.
    keymap = {
      preset = "super-tab",
    },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      list = {
        max_items = 10,
      },
    },

    signature = { enabled = true },

    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = true,
        }
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { "sources.default" },
}
