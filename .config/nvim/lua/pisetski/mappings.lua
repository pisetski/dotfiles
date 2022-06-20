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

return mappings
