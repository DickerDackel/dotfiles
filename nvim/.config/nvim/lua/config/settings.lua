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
vim.o.expandtab = true
vim.o.sidescroll = 10
vim.o.scrolloff = 5
vim.o.foldnestmax = 2
vim.opt.formatoptions = 'jcroql2'
-- Good for moving around, bad for e.g. changing with ciw
-- vim.opt.iskeyword:remove '_'
vim.o.linebreak = true
vim.o.wrap = false
vim.o.shiftwidth = 4
vim.o.showmatch = true
-- vim.o.smartindent = true
vim.o.textwidth = 78
vim.o.virtualedit = 'block'
vim.o.visualbell = true
vim.o.wildmode = 'list:longest'

vim.cmd 'cabbrev help vert bo help'
vim.cmd 'iabbrev ml@ michael.lamertz@gmail.com'
vim.cmd 'iabbrev ml! Michael Lamertz'

-- add matchit native plugin (:help matchit)
vim.cmd 'runtime macros/matchit.vim'

vim.opt.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp = '␣'}
-- vim.o.listchars = {eol = '↵', trail = '~', tab = '>-', nbsp = '␣'}
-- vim.o.listchars = {tab = '▷', trail = '·', extends = '◣', precedes = '◢', nbsp = '○'}
vim.cmd('match errorMsg /\\s\\+$/')
