local mappings = {}

local function map(kind, lhs, rhs, silentnoremap)
  vim.api.nvim_set_keymap(kind, lhs, rhs, silentnoremap)
end

local silentnoremap = { noremap = true, silent = true }

-- Make 0 take me to the first non-blank character of the line
map('n', '0', '^', silentnoremap)

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz', silentnoremap)
map('n', 'N', 'Nzz', silentnoremap)

-- Conveniently enter command mode
map('n', ';', ':', { noremap = true })

-- Reset highlighting after search
map('n', '<CR>', ':noh<CR><CR>', { noremap = true })

map('n', '<C-J>', '<C-W><C-J>', silentnoremap) -- More easily switch window downwards
map('n', '<C-K>', '<C-W><C-K>', silentnoremap) -- More easily switch window upwards
map('n', '<C-L>', '<C-W><C-L>', silentnoremap) -- More easily switch window right
map('n', '<C-H>', '<C-W><C-H>', silentnoremap) -- More easily switch window left

function mappings:mapLSP()
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, silentnoremap)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, silentnoremap)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, silentnoremap)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, silentnoremap)
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', silentnoremap)

  map('n', '?R', '<cmd>Telescope lsp_references<cr>', silentnoremap) -- Pop open a window for finding references to the word under the cursor
  map('n', '?T', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', silentnoremap) -- Find any type in the workspace dynamically
  map('n', '?i', '<cmd>Telescope lsp_implementations<cr>', silentnoremap) -- Find implementations of an interface
end

function mappings:mapLSPDiagnostics()
  vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, silentnoremap)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, silentnoremap)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, silentnoremap)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, silentnoremap)
end

function mappings:mapNvimTree()
  map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', silentnoremap) -- Open/close file browser
  map('n', '<leader>E', '<cmd>NvimTreeFindFile<cr>', silentnoremap) -- Find the current file in file browser
end

function mappings:mapTelescope()
  map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', silentnoremap)
  map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', silentnoremap)
  map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', silentnoremap)
  map('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', silentnoremap)
  map('n', '<leader>fv', '<cmd>Telescope git_branches<cr>', silentnoremap) -- List VCS branches
  map('n', '<leader>fc', '<cmd>Telescope git_commits<cr>', silentnoremap)
  map('n', '<leader>fy', '<cmd>Telescope neoclip<cr>', silentnoremap)
  map('n', '<leader>fm', '<cmd>Telescope marks<cr>', silentnoremap)
end

function mappings:mapCompletion()
  map('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  map('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  map('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  map('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  map('i', '<C-E>', '<Plug>luasnip-next-choice', {})
  map('s', '<C-E>', '<Plug>luasnip-next-choice', {})
end

function mappings:mapNeogit()
  map('n', '<leader>g', '<cmd>Neogit<cr>', silentnoremap)
end

return mappings
