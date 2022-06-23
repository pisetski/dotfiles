local mappings = {}

local function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

local silentnoremap = {noremap = true, silent = true}

-- Make 0 take me to the first non-blank character of the line
map('n', '0', '^', silentnoremap)

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz', silentnoremap)
map('n', 'N', 'Nzz', silentnoremap)

-- Conveniently enter command mode
map('n', ';', ':', {noremap=true})

-- Easy search
map('n', '<space>', '/', {noremap=true})
map('n', '<C-space>', '?', {noremap=true})


map('n', '<CR>', ':noh<CR><CR>', {noremap=true})


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
end

function mappings:mapCompletion()
  map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
  map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
  map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
  map("i", "<C-E>", "<Plug>luasnip-next-choice", {})
  map("s", "<C-E>", "<Plug>luasnip-next-choice", {})
end

return mappings
