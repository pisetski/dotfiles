local silentnoremap = { noremap = true, silent = true }
local map = function(mode, keymap, action, opts)
  vim.api.nvim_set_keymap(mode, keymap, action, opts or silentnoremap)
end

-- Make 0 take me to the first non-blank character of the line
map('n', '0', '^')

-- Make the search results always appear in the middle of the screen
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')

-- Reset highlighting after search
map('n', '<CR>', ':noh<CR><CR>', silentnoremap)

-- Resize with arrows
map('n', '<A-Up>', ':resize -2<CR>')
map('n', '<A-Down>', ':resize +2<CR>')
map('n', '<A-Left>', ':vertical resize -2<CR>')
map('n', '<A-Right>', ':vertical resize +2<CR>')

-- Better window navigation
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')

-- Easy access to normal mode from insert mode
map('i', 'jk', '<esc>')

-- Make Shift-Tab unindent
map('i', '<S-Tab>', '<C-d>')

-- Close windows quicker
map('n', 'q', '<C-w>q')
map('n', 'Q', ':tabclose<CR>')

-- Quick-save the current buffer
map('n', '<C-S>', '<C-c>:update<cr>')
map('i', '<C-S>', '<C-c>:update<cr>')
map('v', '<C-S>', '<C-c>:update<cr>')

-- Copy into blackhole register, e.g., "_ciw
map('n', '<leader>b', '"_')

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
map('n', '<A-j>', '<Esc>:m .+1<CR>==')
map('n', '<A-k>', '<Esc>:m .-2<CR>==')
map('v', '<A-j>', ':m .+1<CR>==')
map('v', '<A-k>', ':m .-2<CR>==')
map('x', '<A-j>', ":move '>+1<CR>gv-gv")
map('x', '<A-k>', ":move '<-2<CR>gv-gv")

-- Stay in indent mode
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Copy current file filename and relative path
map('n', '<leader>yf', ':let @+=@%<CR> :echo "Path copied:" expand("%")<CR>')

-- Predictive line movement
map('n', 'j', 'gj')
map('n', 'k', 'gk')

return map
