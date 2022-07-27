local mappings = {}

local map = vim.api.nvim_set_keymap

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

-- Resize with arrows
map("n", "<A-Up>", ":resize -2<CR>", silentnoremap)
map("n", "<A-Down>", ":resize +2<CR>", silentnoremap)
map("n", "<A-Left>", ":vertical resize -2<CR>", silentnoremap)
map("n", "<A-Right>", ":vertical resize +2<CR>", silentnoremap)

-- Better window navigation
map('n', '<C-J>', '<C-W><C-J>', silentnoremap)
map('n', '<C-K>', '<C-W><C-K>', silentnoremap)
map('n', '<C-L>', '<C-W><C-L>', silentnoremap)
map('n', '<C-H>', '<C-W><C-H>', silentnoremap)

-- Easy access to normal mode from insert mode
map('i', 'jk', '<esc>', silentnoremap)

-- Make Shift-Tab unindent
map('i', '<S-Tab>', '<C-d>', silentnoremap)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", silentnoremap)
map("n", "<S-h>", ":bprevious<CR>", silentnoremap)

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi", silentnoremap)
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi", silentnoremap)
map("v", "<A-j>", ":m .+1<CR>==", silentnoremap)
map("v", "<A-k>", ":m .-2<CR>==", silentnoremap)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", silentnoremap)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", silentnoremap)

-- Stay in indent mode
map("v", "<", "<gv", silentnoremap)
map("v", ">", ">gv", silentnoremap)

-- Quick-save the current buffer
map('n', '<leader>w', '<cmd>w<cr>', { noremap = true })

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
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, silentnoremap)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, silentnoremap)
end

function mappings:mapNvimTree()
  map('n', '<leader>E', '<cmd>NvimTreeToggle<cr>', silentnoremap) -- Open/close file browser
  map('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', silentnoremap) -- Find the current file in file browser
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
  map('i', '<C-E>', '<Plug>luasnip-next-choice', {})
  map('s', '<C-E>', '<Plug>luasnip-next-choice', {})
end

function mappings:mapNeogit()
  map('n', '<leader>g', '<cmd>Neogit<cr>', silentnoremap)
end

function mappings:mapGitlinker()
  map('n', '<leader>V',
    '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { silent = true })
end

function mappings:mapTrouble()
  map("n", "<leader>xx", "<cmd>Trouble<cr>", silentnoremap)
  map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", silentnoremap)
  map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", silentnoremap)
  map("n", "gr", "<cmd>Trouble lsp_references<cr>", silentnoremap)
end

return mappings
