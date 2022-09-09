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
map('n', '<A-Up>', ':resize -2<CR>', silentnoremap)
map('n', '<A-Down>', ':resize +2<CR>', silentnoremap)
map('n', '<A-Left>', ':vertical resize -2<CR>', silentnoremap)
map('n', '<A-Right>', ':vertical resize +2<CR>', silentnoremap)

-- Better window navigation
map('n', '<C-J>', '<C-W><C-J>', silentnoremap)
map('n', '<C-K>', '<C-W><C-K>', silentnoremap)
map('n', '<C-L>', '<C-W><C-L>', silentnoremap)
map('n', '<C-H>', '<C-W><C-H>', silentnoremap)

-- Easy access to normal mode from insert mode
map('i', 'jk', '<esc>', silentnoremap)

-- Make Shift-Tab unindent
map('i', '<S-Tab>', '<C-d>', silentnoremap)

-- Close windows quicker
map('n', 'q', '<C-w>q', silentnoremap)

-- Move text up and down
map('n', '<A-j>', '<Esc>:m .+1<CR>==gi', silentnoremap)
map('n', '<A-k>', '<Esc>:m .-2<CR>==gi', silentnoremap)
map('v', '<A-j>', ':m .+1<CR>==', silentnoremap)
map('v', '<A-k>', ':m .-2<CR>==', silentnoremap)
map('x', '<A-j>', ":move '>+1<CR>gv-gv", silentnoremap)
map('x', '<A-k>', ":move '<-2<CR>gv-gv", silentnoremap)

-- Stay in indent mode
map('v', '<', '<gv', silentnoremap)
map('v', '>', '>gv', silentnoremap)

-- Quick-save the current buffer
map('n', '<leader>w', '<cmd>w<cr>', { noremap = true })

-- LazyGit
map('n', '<leader>g', '<cmd>LazyGit<cr>', silentnoremap)

function mappings:mapLSP()
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, silentnoremap)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, silentnoremap)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, silentnoremap)
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', silentnoremap)
end

function mappings:mapLSPDiagnostics()
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, silentnoremap)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, silentnoremap)
end

function mappings:mapNvimTree()
  map('n', '<leader>E', '<cmd>NvimTreeFindFile<cr>', silentnoremap)
  map('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', silentnoremap) -- Find the current file in file browser
end

function mappings:mapGitlinker()
  map('n', '<leader>L',
    '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
    { silent = true })
end

function mappings:mapTrouble()
  map('n', '<leader>xx', '<cmd>Trouble<cr>', silentnoremap)
  map('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', silentnoremap)
  map('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', silentnoremap)
  map('n', 'gr', '<cmd>Trouble lsp_references<cr>', silentnoremap)
  map('n', 'gd', '<cmd>Trouble lsp_definitions<cr>', silentnoremap)
end

function mappings:mapFzf()
  map('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", silentnoremap)
  map('n', '<c-G>', "<cmd>lua require('fzf-lua').live_grep_native()<CR>", silentnoremap)
  map('n', '<leader>fj', "<cmd>lua require('fzf-lua').jumps()<CR>", silentnoremap)
  map('n', '<leader>fb', "<cmd>lua require('fzf-lua').buffers()<CR>", silentnoremap)
  map('n', '<leader>fr', "<cmd>lua require('fzf-lua').oldfiles()<CR>", silentnoremap)
  map('n', '<leader>fv', "<cmd>lua require('fzf-lua').git_branches()<CR>", silentnoremap)
  map('n', '<leader>fm', "<cmd>lua require('fzf-lua').marks()<CR>", silentnoremap)
  map('n', '<leader>fy', "<cmd>lua require('fzf-lua').registers()<CR>", silentnoremap)
  map('n', '<leader>fw', "<cmd>lua require('fzf-lua').grep_cword()<CR>", silentnoremap)
  map('n', '<leader>fW', "<cmd>lua require('fzf-lua').grep_cWORD()<CR>", silentnoremap)

  -- Pass custom cwd to grep
  map('n', '<leader>fd', ":FzfLua live_grep_native cwd=./", { noremap = true })
end

return mappings
