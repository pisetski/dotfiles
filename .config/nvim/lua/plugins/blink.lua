return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap. when defining your own, no keybinds will be assigned automatically.
    keymap = 'super-tab',

    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'mono',

    windows = {
      autocomplete = {
        -- Controls how the completion items are rendered on the popup window
        -- 'simple' will render the item's kind icon the left alongside the label
        -- 'reversed' will render the label on the left and the kind icon + name on the right
        -- 'minimal' will render the label on the left and the kind name on the right
        -- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
        draw = 'reversed'
      },
    },

    -- experimental auto-brackets support
    -- accept = { auto_brackets = { enabled = true } }

    -- experimental signature help support
    trigger = { signature_help = { enabled = true } }
  }
}
