vim.cmd('colorscheme nord')

vim.g.swapfile = false
vim.g.lazyredraw = true
vim.g.nocompatible = true -- disable compatibility to old-time vi
vim.g.nobackup = true
vim.g.nowb = true

local o = vim.o

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
o.timeoutlen=400 -- Time to wait in milliseconds between hitting the first key of a multi-key mapping
o.ttimeoutlen=0  -- Ensure that there's no delay between esc-ing and the next command executing
o.termguicolors = true

-- How to represent non-printable characters. In general, don't want tabs, so
-- have them show up as special characters.
o.listchars='tab:>-,trail:·,extends:>,precedes:<'
o.list = true -- turn the above on

-- Define the window border characters for splits etc.
-- o.fillchars = vim.o.fillchars .. 'vert:│,fold: ,diff: '

vim.cmd('filetype plugin on')
vim.cmd('filetype plugin indent on')
vim.cmd('set noshowmode')
