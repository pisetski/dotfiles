local o = vim.o
local g = vim.g

o.showmatch = true -- show matching
o.ignorecase = true -- case insensitive
o.mouse = 'v' -- middle-click paste with
o.hlsearch = true -- highlight search
o.incsearch = true -- incremental search
o.tabstop = 2 -- number of columns occupied by a tab
o.softtabstop = 2 -- see multiple spaces as tabstops so <BS> does the right thing
o.expandtab = true -- converts tabs to white space
o.shiftwidth = 2 -- width for autoindents
o.autoindent = true -- indent a new line the same amount as the line just typed
o.scrolloff = 8 -- Number of lines from vertical edge to start scroll
o.sidescrolloff = 15 -- Number of lines from horizontal edge to start scroll
o.sidescroll = 6 -- Number of columns to scroll at a time
o.number = true -- add line numbers
o.wildmode = 'longest,list' -- get bash-like tab completions
o.mouse = 'a' -- enable mouseclick
o.clipboard = 'unnamedplus' -- using system clipboard
o.cursorline = true -- highlight current cursorline
o.ttyfast = true -- Speed up scrolling in Vim
o.updatetime = 300
o.smarttab = true
o.si = true
o.magic = true
o.scrolloff = 5
o.signcolumn = 'yes'
o.autoread = true -- Automatically read file when edited outside of vim
o.timeoutlen = 400 -- Time to wait in milliseconds between hitting the first key of a multi-key mapping
o.ttimeoutlen = 0 -- Ensure that there's no delay between esc-ing and the next command executing
o.termguicolors = true
o.backup = false
o.writebackup = false
o.swapfile = false
o.lazyredraw = true --Don't attempt to render macros for example
o.backspace = 'indent,eol,start' -- Make deleting natural
o.autowrite = true -- Make No write since last change stfu
o.listchars = 'tab:>-,trail:·,extends:>,precedes:<' -- How to represent non-printable characters.
o.list = true -- turn the above on
o.formatoptions = o.formatoptions .. 'j' -- Behave more reasonable when merging lines with J

vim.api.nvim_create_autocmd(
  { 'bufread', 'bufnewfile' },
  { pattern = { '*.jenkinsfile', '*.jenkinsfile', 'jenkinsfile', 'jenkinsfile' }, command = 'setf groovy' }
)
vim.api.nvim_create_autocmd(
  { 'bufread', 'bufnewfile' },
  { pattern = { '*.gohtml' }, command = 'setf htmldjango' }
)

-- Disable unused builtins
local builtins = {
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'matchit',
  'matchparen',
  'logiPat',
  'rrhelper',
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
}

for _, plugin in ipairs(builtins) do
  g['loaded_' .. plugin] = 1
end

vim.cmd('filetype plugin on')
vim.cmd('set noshowmode')
vim.cmd('colorscheme tokyonight')

vim.api.nvim_command('au TextYankPost * silent! lua vim.highlight.on_yank()')
