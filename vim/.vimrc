set nocompatible

" Dunno why, was needed for some reason
filetype off
if has('win32')
    " neovim needs pynvim for the LSP.  If you don't want to install it into
    " every active venv, vim must be forced to use the system wide python
    " instead of the venv.  Shitty, must be changed for every python update.
    " let g:python3_host_prog = 'c:/python312/python.exe'
    set rtp-=~/.vimfiles
    set rtp+=~/.vim
endif

" ======================================================================
" use vim-plug to manage packages
" ======================================================================
"
" Bootstrap vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
" 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')
    "-------------------------------------------------------------------
    " Keepers
    "-------------------------------------------------------------------
    Plug 'mhinz/vim-startify'
    let g:startify_session_persistence = 1

    " IDE stuff
    Plug 'majutsushi/tagbar'

    " Python
    if has('python3')
	Plug 'davidhalter/jedi-vim'
    endif

    " Fix those fcking bracket indents!
    Plug 'vimjas/vim-python-pep8-indent'
    Plug 'nvie/vim-flake8'

    " fancy status bar
    if !has('win32')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    endif

    " Snippets - These belong together
    if v:version >= 800 && has('python3')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
    endif

    "-------------------------------------------------------------------
    " Evaluate
    "-------------------------------------------------------------------

    " Distraction free writing
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'dense-analysis/ale'
    Plug 'neovim/nvim-lspconfig'

    " Line wrapping for distraction free writing
    Plug 'reedes/vim-pencil'

    "-------------------------------------------------------------------
    " Experimental
    "-------------------------------------------------------------------
    if has('nvim')
	Plug 'nvim-treesitter/nvim-treesitter'
    endif

    " Git integration
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-markdown'

    " FZF
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " Alternative to nerdcommenter
    Plug 'tpope/vim-commentary'

    Plug 'folke/which-key.nvim'

call plug#end()

filetype plugin indent on

" ======================================================================
" Settings for the plugins above
" ======================================================================

    " --------------------------------
    " Airline
    " --------------------------------
	let g:airline_exclude_preview = 0
	let g:airline#extensions#tagbar#enabled = 0
	"let g:airline#extensions#tagbar#flags = ''
	"let g:airline#extensions#tagbar#flags = 'f'
	"let g:airline#extensions#tagbar#flags = 's'
	"let g:airline#extensions#tagbar#flags = 'p'

    " --------------------------------
    " Pencil
    " --------------------------------
	"  Auto activation of pencil disabled, since it was annoying.  Use
	"  :PencilToggle or :PencilOn instead when you need it.
	"augroup pencil
	    "autocmd!
	    "autocmd FileType markdown,mkd call pencil#init()
	    "autocmd FileType text         call pencil#init()
	"augroup END
	:noremap <leader>P :PencilToggle<CR>

    " --------------------------------
    " jedi-vim
    " --------------------------------
        let g:jedi#use_tabs_not_buffers = 1
	let g:jedi#popup_select_first = 1
	set completeopt=menuone,longest,popup

    " --------------------------------
    " goyo
    " --------------------------------
	:noremap <leader>G :Goyo<CR>

    " --------------------------------
    " fzf
    " --------------------------------
	:noremap <C-p> :Files<CR>
	:noremap <leader>g :GFiles<CR>
	:noremap <leader>b :Buffers<CR>
	if has('win32')
	:let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow'
	endif

    " --------------------------------
    " Tagbar
    " --------------------------------
	:noremap <leader>t :TagbarToggle<CR>

    " --------------------------------
    " ctrlp
    " --------------------------------
	" let g:ctrlp_show_hidden=1

    " --------------------------------
    " snipmate
    " --------------------------------
    "  This seems broken and unmaintained.  Ultisnips requires python built
    "  in, but I'll try this now
	"let g:snips_author = 'Michael Lamertz'
	"let g:snipMate = { 'snippet_version' : 1 }
        "
    " --------------------------------
    " UltiSnips
    " --------------------------------
        " let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = '~/.vim/ultisnips'
	let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'ultisnips']
	let g:UltiSnipsExpandTrigger = '<tab>'
	let g:UltiSnipsListSnippets = '<s-tab>'
	let g:UltiSnipsJumpForwardTrigger = '<c-j>'
	let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
	let g:UltiSnipsEditSplit="context"
        " let g:ultisnips_python_quoting_style = 'single'
        " let g:ultisnips_python_triple_quoting_style = 'double'

    " --------------------------------
    " from the limelight homepage
    " --------------------------------
	let g:limelight_conceal_ctermfg = 'gray'
	let g:limelight_conceal_ctermfg = 240

	" Color name (:help gui-colors) or RGB color
	let g:limelight_conceal_guifg = 'DarkGray'
	let g:limelight_conceal_guifg = '#777777'

	" Default: 0.5
	let g:limelight_default_coefficient = 0.7

	" Number of preceding/following paragraphs to include (default: 0)
	let g:limelight_paragraph_span = 1

	" Beginning/end of paragraph
	"   When there's no empty line between the paragraphs
	"   and each paragraph starts with indentation
	let g:limelight_bop = '^\s'
	let g:limelight_eop = '\ze\n^\s'

	" Highlighting priority (default: 10)
	"   Set it to -1 not to overrule hlsearch
	let g:limelight_priority = -1

	:noremap <leader>l :Limelight [0.0 ~ 1.0]<CR>

    " --------------------------------
    " SimplyFold
    " --------------------------------
	let g:SimplyFold_docstring_preview = 1

    " --------------------------------
    " ALE
    " --------------------------------
    :noremap <leader>A :ALEToggle<CR>
    let g:ale_linters = {'python': ['ruff']}
    let g:ale_fixers = {'python': ['ruff']}
    let g:ale_sign_column_always = 1
    let g:ale_sign_highlight_linenrs = 1
    let g:ale_virtualtext_cursor = 'disabled'
"    "let g:ale_virtualtext_column = 60
"    let g:ale_echo_cursor = 
"    let g:ale_virtualtext_cursor =
    
    :hi ALEErrorLine ctermbg=13
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

    " --------------------------------
    " Markdown
    " --------------------------------
    let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
    let g:markdown_syntax_conceal = 0
    let g:markdown_minlines = 1000


" ======================================================================
" My normal stuff
" ======================================================================

syntax on
" colorscheme zenburn
" let g:zenburn_high_Contrast=1
" colorscheme astronaut
colorscheme vividchalk
if &diff
    colorscheme vividchalk
endif

:set notermguicolors
:function! MyPostPatch()
:  hi  Cursor       cterm=NONE       gui=reverse    ctermfg=black  guifg=black ctermbg=white     guibg=white
:  hi  TermCursor   cterm=NONE       gui=reverse    ctermfg=black  guifg=black ctermbg=white     guibg=white
:  hi  CursorLine   cterm=NONE       gui=NONE       ctermfg=NONE   guifg=NONE  ctermbg=235       guibg=#202020
:  hi  Search       cterm=reverse    gui=reverse    ctermfg=cyan   guifg=cyan  ctermbg=black     guibg=black
:  hi  IncSearch    cterm=reverse    gui=reverse    ctermfg=cyan   guifg=cyan  ctermbg=black     guibg=black
:  hi  CurSearch    cterm=NONE       gui=NONE       ctermfg=cyan   guifg=cyan  ctermbg=black     guibg=black
:  hi  Comment      ctermfg=Grey     ctermbg=NONE   guifg=Grey     guibg=NONE                      
:  hi  Folded       ctermfg=red      ctermbg=NONE   guifg=red      guibg=NONE                      
:  hi  ColorColumn  ctermbg=darkgrey guibg=#101010                                                 
:  hi  LineNr       ctermfg=7        ctermbg=0      guifg=DarkGrey guibg=black                     
:  hi  SpellCap     ctermbg=81       ctermfg=black
:  hi  MatchParen   cterm=NONE       ctermfg=yellow ctermbg=black
:  hi  DiffDelete   ctermfg=0        ctermbg=241
:  hi  DiffAdd      ctermfg=blue     ctermbg=white

" ALE left column
":  hi clear             SignColumn
:  set iskeyword=@,48-57,_
":  set iskeyword=@,48-57,
:endfunction

:noremap <leader>p :set invpaste<CR>
set nopaste
:noremap <leader>h :set invhlsearch<CR>
set hlsearch
:noremap <leader>w :set invwrap<CR>
set nowrap

:noremap <leader>e yy:@"<CR>

if has('win32')
    :noremap <leader>v :sp ~/_vimrc<CR><C-W>_
else
    :noremap <leader>v :sp ~/.vimrc<CR><C-W>_
C'endif
:noremap <leader>V :source %<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

:set splitright
:noremap <leader>s :split<CR><C-W><C-j>:next<CR>
:noremap <leader>S :vsplit<CR><C-W><C-j>:next<CR>

" https://www.youtube.com/watch?v=MquaityA1SM
" Execute line under cursor as shell command
:noremap <leader>Q !!$SHELL<CR>

:noremap <leader>n :set invnumber<CR>

:noremap <leader><Space> dipO<Esc>

" Use Ctrl-L (redraw screen) to clear search highlighting temporarily
:noremap <nowait><silent> <C-L> :noh<CR>:redraw!<CR>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Make Ctrl-W m maximize the current pane
nnoremap <C-W>m <C-W>\|<C-W>

" Folding
nnoremap f za
vnoremap f za
nnoremap F zA
vnoremap F zA

" replaced by vim-airline
"set statusline=%<%f\ %h%w%m%y%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set magic
set mouse=a
set smartindent
set shiftwidth=4
set textwidth=78
set formatoptions-=t
set noshiftround
set smarttab
set visualbell
set wildmenu
set wildmode=list:longest
:noremap <leader>f :set foldmethod=manual<CR>
:noremap <leader>F :set foldmethod=indent<CR>
set foldmethod=manual
" set foldmethod=indent
set foldnestmax=2
set showmatch
set backspace=indent,eol,start
set virtualedit=block
set background=dark
set t_Co=256
if !has('nvim')
    set esckeys
endif
set noautochdir

" Dunno why i overrode that, defaults are much more useful:
" sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal
" set sessionoptions=buffers

" Prettier wrapping of long lines
set nowrap
set linebreak
"set showbreak=>>

set modeline

" Searching
set smartcase
set ignorecase
set incsearch
" set nowrapscan

set scrolloff=3
set autoread

" New feature 'undofile'
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

let python_highlight_all=1

augroup filetypedetect
    au BufNewFile,BufRead *.txt		set wrap wrapmargin=7
    au BufNewFile,BufRead *.kata	set wrap wrapmargin=7
    au BufNewFile,BufRead *.kata	set filetype=txt
    au BufNewFile,BufRead *.sls		set filetype=yaml sw=4

    au FileType python			set expandtab smarttab autoindent smartindent number cursorline
    au FileType yaml			set expandtab smarttab autoindent smartindent number cursorline
    au FileType mkd			setl autoindent colorcolumn=0 linebreak nonumber wrap
    au FileType markdown		setl autoindent colorcolumn=0 linebreak nonumber wrap
    au FileType text			setl autoindent colorcolumn=0 linebreak nonumber wrap
    au BufNewFile,BufRead *		call MyPostPatch()
augroup END

" add matchit native plugin (:help matchit)
runtime macros/matchit.vim

:cabbrev help vert bo help
:iabbrev ml@ michael.lamertz@gmail.com
:iabbrev ml! Michael Lamertz
let @d = "ooprint(f'{=}')hhh\"\"PA"
