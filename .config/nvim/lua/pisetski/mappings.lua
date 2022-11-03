local mappings = {}

local map = vim.api.nvim_set_keymap

local silentnoremap = { noremap = true, silent = true }

-- Make 0 take me to the first non-blank character of the line
map('n', '0', '^', silentnoremap)

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz', silentnoremap)
map('n', 'N', 'Nzz', silentnoremap)

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

-- Quick-save the current buffer
map('n', '<C-S>', '<C-c>:update<cr>', silentnoremap)
map('i', '<C-S>', '<C-c>:update<cr>', silentnoremap)
map('v', '<C-S>', '<C-c>:update<cr>', silentnoremap)

-- Copy into blackhole register, e.g., "_ciw
map('n', '<leader>b', '"_', silentnoremap)

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
map('n', 'c.', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
map('n', '<leader>c.', [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Map <leader>o & <leader>O to newline without insert mode
map('n', '<leader>o',
  ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
  silentnoremap)
map('n', '<leader>O',
  ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
  silentnoremap)

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

-- LazyGit
map('n', '<leader>g', '<cmd>LazyGit<cr>', silentnoremap)

-- ToggleTerm
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

function mappings:mapLSP(_, bufnr)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  -- vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  vim.keymap.set(
    'n',
    '<space>f',
    function() vim.lsp.buf.format {
        async = true,
        filter = function(client) return client.name ~= "tsserver" end
      }
    end,
    bufopts
  )
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
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
  map('n', 'gi', '<cmd>Trouble lsp_implementations<cr>', silentnoremap)
  map('n', '<space>D', '<cmd>Trouble lsp_type_definitions<cr>', silentnoremap)
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
  map('n', '<leader>fs', "<cmd>lua require('fzf-lua').git_status()<CR>", silentnoremap)

  -- Pass custom cwd to grep
  map('n', '<leader>fd', ":FzfLua live_grep_native cwd=./", { noremap = true })
end

function mappings:mapHlslens()
  map('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    silentnoremap)
  map('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    silentnoremap)
  map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], silentnoremap)
  map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], silentnoremap)
  map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], silentnoremap)
  map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], silentnoremap)

end

return mappings
