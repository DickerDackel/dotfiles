set nocompatible

" ======================================================================
" use Vundle to manage packages
" ======================================================================

" Brilliant:
" https://www.reddit.com/r/vim/comments/43ufir/should_i_install_vundle_as_a_submodule_in_my/czlg8uj/
" Vundle bootstrap
if !filereadable($HOME . '/.vim/bundle/vundle/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
    exec '!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle/'
endif


filetype off
set rtp+=~/.vim/bundle/vundle/
if has('win32')
    set rtp-=~/.vimfiles
    set rtp+=~/.vim
endif

call vundle#rc()
    " Required because Vundle would otherwise remove itself on VundleClean
    Plugin 'gmarik/vundle'

    "-------------------------------------------------------------------
    " Keepers
    "-------------------------------------------------------------------
    " Helpful
    "kien/ctrlp is no longer maintained
    "Plugin 'kien/ctrlp.vim'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'mhinz/vim-startify'
    Plugin 'mg979/vim-visual-multi'

    " IDE stuff
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'majutsushi/tagbar'

    " fancy status bar
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " Snippets - These belong together
    "Plugin 'MarcWeber/vim-addon-mw-utils'
    "Plugin 'tomtom/tlib_vim'
    "Plugin 'garbas/vim-snipmate'

    Plugin 'SirVer/ultisnips'
    Plugin 'honza/vim-snippets'

    "-------------------------------------------------------------------
    " Evaluate
    "-------------------------------------------------------------------

    " Distraction free writing
    Plugin 'junegunn/goyo.vim'
    Plugin 'junegunn/limelight.vim'
    Plugin 'dense-analysis/ale'

    "-------------------------------------------------------------------
    " Experimental
    "-------------------------------------------------------------------

    " Line wrapping for distraction free writing
    Plugin 'reedes/vim-pencil'

    " Git integration
    Plugin 'tpope/vim-fugitive'

    " Abolish preserves case on find and replace, among other things
    Plugin 'tpope/vim-abolish'

    Plugin 'altercation/vim-colors-solarized'
    Plugin 'davidhalter/jedi-vim'
    "Plugin 'ervandew/supertab.git'

    " Fix those fcking bracket indents!
    Plugin 'vimjas/vim-python-pep8-indent'
    " Don't use auto pairs, it's annoying as fuck!
    "Plugin 'jiangmiao/auto-pairs'
    Plugin 'nvie/vim-flake8'

call vundle#end() 

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
	let g:jedi#popup_on_dot = 0
	let g:jedi#show_call_signatures = 2
	let g:jedi#use_splits_not_buffers = "bottom"
	let g:jedi#popup_select_first = 0

    " --------------------------------
    " goyo
    " --------------------------------
	:noremap <leader>G :Goyo<CR>

    " --------------------------------
    " NERDTree
    " --------------------------------
	:noremap <leader>T :NERDTreeToggle<CR>

    " --------------------------------
    " NERDCommenter
    " --------------------------------
        let NERDCommentEmptyLines = 1
        let NERDDefaultAlign = 'left'
        let NERDRemoveExtraSpaces = 1

    " --------------------------------
    " Tagbar
    " --------------------------------
	:noremap <leader>t :TagbarToggle<CR>

    " --------------------------------
    " ctrlp
    " --------------------------------
	let g:ctrlp_show_hidden=1

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
    let g:ale_linters = {'python': ['flake8']}
    let g:ale_sign_column_always = 1
    let g:ale_sign_highlight_linenrs = 1
    let g:ale_virtualtext_cursor = 'disabled'
"    "let g:ale_virtualtext_column = 60
"    let g:ale_echo_cursor = 
"    let g:ale_virtualtext_cursor =
    
    :hi ALEErrorLine ctermbg=13
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)


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

:function! MyPostPatch()
:  hi Search term=reverse ctermfg=black ctermbg=yellow
:  hi IncSearch ctermfg=yellow ctermbg=black
:  hi Comment term=NONE ctermfg=Grey ctermbg=NONE
:  hi Folded term=NONE ctermfg=red ctermbg=NONE
:  hi ColorColumn ctermbg=234
:  hi LineNr ctermfg=7 ctermbg=0 guifg=LightGrey guibg=DarkGrey
"  ALE left column
:  hi clear SignColumn
:  set iskeyword=@,48-57
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
endif
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
:noremap <nowait><silent> <C-L> :noh<CR>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

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
set noshiftround
set smarttab
set visualbell
set wildmenu
set wildmode=list:longest
set foldmethod=indent
set foldnestmax=2
set showmatch
set backspace=indent,eol,start
set virtualedit=block
set background=dark
set t_Co=256
if !has('nvim')
    set esckeys
endif

set sessionoptions=buffers

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
    au BufNewFile,BufRead *.sls		set filetype=yaml
    au BufNewFile,BufRead *.markdown 	set filetype=mkd
    au BufNewFile,BufRead *.md       	set filetype=mkd

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
