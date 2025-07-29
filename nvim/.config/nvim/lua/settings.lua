------------------------------------------------------------------------
-- from kickstart.vim
------------------------------------------------------------------------
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.confirm = true

-- from kickstart.vim, test
vim.o.breakindent = true
vim.o.signcolumn = 'yes'

------------------------------------------------------------------------
-- Mine...
------------------------------------------------------------------------
vim.o.scrolloff = 3
vim.o.foldnestmax = 2
vim.opt.formatoptions:remove 't'
-- Good for moving around, bad for e.g. changing with ciw
-- vim.opt.iskeyword:remove '_'
vim.o.linebreak = true
vim.o.wrap = false
vim.o.shiftwidth = 4
vim.o.showmatch = true
vim.o.smartindent = true
vim.o.textwidth = 78
vim.o.virtualedit = 'block'
vim.o.visualbell = true
vim.o.wildmode = 'list:longest'

vim.cmd 'cabbrev help vert bo help'
vim.cmd ':iabbrev ml@ michael.lamertz@gmail.com'
vim.cmd ':iabbrev ml! Michael Lamertz'

-- add matchit native plugin (:help matchit)
vim.cmd 'runtime macros/matchit.vim'

-- Why?!?
-- set notermguicolors

-- Removed, left as reminder
-- "set showbreak=>>
-- "set statusline=%<%f\ %h%w%m%y%r%=%-14.(%l,%c%V%)\ %P

-- These are not available in neovim
-- set esckeys
-- set t_Co=256

-- These are default in neovim
-- vim.o.background=dark
-- vim.o.autoread = true
-- vim.o.termguicolors = true
-- vim.o.backspace=indent,eol,start
-- vim.o.foldmethod=manual
-- vim.o.hlsearch = true
-- vim.o.incsearch = true
-- vim.o.laststatus=2
-- vim.o.magic = true
-- vim.o.modeline = true
-- vim.o.noautochdir = true
-- vim.o.nocompatible = true
-- vim.o.nopaste = true
-- vim.o.noshiftround = true
-- vim.o.smarttab = true
-- vim.o.wildmenu = true
