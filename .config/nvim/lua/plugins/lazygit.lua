return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function()
    local tmux_pane_flags = { h = 'L', j = 'D', k = 'U', l = 'R' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'lazygit',
      callback = function(args)
        for key, flag in pairs(tmux_pane_flags) do
          vim.keymap.set('t', '<C-' .. key .. '>', function()
            vim.system({ 'tmux', 'select-pane', '-' .. flag })
          end, { buffer = args.buf })
        end
      end,
    })
  end,
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<space>g", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
}
