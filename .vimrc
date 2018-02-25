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
call vundle#rc()
Plugin 'VundleVim/Vundle.vim'
" Keepers
Plugin 'kien/ctrlp.vim'
" Evaluate
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mhinz/vim-startify'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
" Experiment
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
filetype plugin indent on

" ======================================================================
" Settings for the plugins above
" ======================================================================
    " --------------------------------
    " ctrlp
    " --------------------------------
	let g:ctrlp_show_hidden=1

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

" ======================================================================
" My normal stuff
" ======================================================================

syntax on
let g:zenburn_high_Contrast=1
" colorscheme zenburn
" colorscheme astronaut
colorscheme vividchalk
if &diff
    colorscheme vividchalk
endif

:function! MyColourpatch()
:  hi Search term=reverse ctermfg=black ctermbg=yellow
:  hi IncSearch ctermfg=yellow ctermbg=black
:  hi Comment term=NONE ctermfg=Grey ctermbg=NONE
:endfunction

" :hi Search ctermbg=grey ctermfg=black
:noremap <leader>p :set invpaste<CR>_
set nopaste
:noremap <leader>h :set invhlsearch<CR>
set hlsearch
:noremap <leader>w :set invwrap<CR>
set nowrap

:noremap <leader>v :sp ~/.vimrc<CR><C-W>_
:noremap <leader>V :source %<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

:set splitright
:noremap <leader>s :split<CR><C-W><C-j>:next<CR>
:noremap <leader>S :vsplit<CR><C-W><C-j>:next<CR>

" https://www.youtube.com/watch?v=MquaityA1SM
" Execute line under cursor as shell command
:noremap <leader>Q !!$SHELL<CR>

:noremap <leader>n :set invnumber<CR>

"set statusline=%<%f\ %h%w%m%y%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set esckeys
set mouse=a
set smartindent
set shiftwidth=4
set smarttab
set visualbell
set wildmenu
set wildmode=list:longest
" set foldmethod=indent
set foldmethod=syntax
:hi Folded term=NONE ctermfg=red ctermbg=NONE
:hi Search term=reverse ctermfg=black ctermbg=yellow
set iskeyword=48-57,A-Z,a-z
" set matchpairs+=<:>
set showmatch
set background=dark
set t_Co=256

set sessionoptions=buffers

" Prettier wrapping of long lines
set nowrap
set linebreak
set showbreak=>>

set modeline

" Searching
set smartcase
set ignorecase
set incsearch
" set nowrapscan

set scrolloff=3
set autoread


let python_highlight_all=1

augroup filetypedetect
    au BufNewFile,BufRead *.html	set wrap wrapmargin=7
    au BufNewFile,BufRead *.tt2		setf html
    au BufNewFile,BufRead *.tt2		set wrap wrapmargin=7
    au BufNewFile,BufRead *.blog	setf html
    au BufNewFile,BufRead *.blog	set wrap wrapmargin=7
    au BufNewFile,BufRead .mailfilter	setf rc
    au BufNewFile,BufRead *.txt		set wrap wrapmargin=7
    au BufNewFile,BufRead *.kata	set wrap wrapmargin=7
    au BufNewFile,BufRead *.kata	setf txt
    au BufNewFile,BufRead *.sls		setf yaml
    au FileType python			set expandtab smarttab autoindent smartindent number cursorline
    au FileType yaml			set expandtab smarttab autoindent smartindent number cursorline
    au BufNewFile,BufRead *		call MyColourpatch()
augroup END

" add matchit native plugin (:help matchit)
runtime macros/matchit.vim


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

syn region Comment start="\[quote" end="\[/quote]" contains=Comment

"	Each status line item is of the form:
"          %-0{minwid}.{maxwid}{item}
"        All fields except the {item} is optional.  A single percent sign can
"        be given as "%%".  Up to 80 items can be specified.
"	    - Left justified
"	    0 leading zeroes
"	    minwid Minimun width, padded with '-' or '0', max 50.
"	    maxwidt ...
"
"        item  meaning ~
"        f S   Path to the file in the buffer, relative to current directory.
"        F S   Full path to the file in the buffer.
"        t S   File name (tail) of file in the buffer.
"        m F   Modified flag, text is " [+]"; " [-]" if 'modifiable' is off.
"        M F   Modified flag, text is ",+" or ",-".
"        r F   Readonly flag, text is " [RO]".
"        R F   Readonly flag, text is ",RO".
"        h F   Help buffer flag, text is " [help]".
"        H F   Help buffer flag, text is ",HLP".
"        w F   Preview window flag, text is " [Preview]".
"        W F   Preview window flag, text is ",PRV".
"        y F   Type of file in the buffer, e.g., " [vim]".  See 'filetype'.
"        Y F   Type of file in the buffer, e.g., ",VIM".  See 'filetype'.
"              {not available when compiled without |+autocmd| feature}
"        k S   Value of "b:keymap_name" or 'keymap' when |:lmap| mappings are
"              being used: "<keymap>"
"        n N   Buffer number.
"        b N   Value of byte under cursor.
"        B N   As above, in hexadecimal.
"        o N   Byte number in file of byte under cursor, first byte is 1.
"              Mnemonic: Offset from start of file (with one added)
"              {not available when compiled without |+byte_offset| feature}
"        O N   As above, in hexadecimal.
"        N N   Printer page number.  (Only works in the 'printheader' option.)
"        l N   Line number.
"        L N   Number of lines in buffer.
"        c N   Column number.
"        v N   Virtual column number.
"        V N   Virtual column number as -{num}.  Not displayed if equal to 'c'.
"        p N   Percentage through file in lines as in |CTRL-G|.
"        P S   Percentage through file of displayed window.  This is like the
"              percentage described for 'ruler'.  Always 3 in length.
"        a S   Argument list status as in default title.  ({current} of {max})
"              Empty if the argument file count is zero or one.
"        { NF  Evaluate expression between '%{' and '}' and substitute result.
"              Note that there is no '%' before the closing '}'.
"        ( -   Start of item group.  Can be used for setting the width and
"              alignment of a section.  Must be followed by %) somewhere.
"        ) -   End of item group.  No width fields allowed.
"        T N   For 'tabline': start of tab page N label.  Use %T after the last
"              label.  This information is used for mouse clicks.
"        X N   For 'tabline': start of close tab N label.  Use %X after the
"              label, e.g.: %3Xclose%X.  Use %999X for a "close current tab"
"              mark.  This information is used for mouse clicks.
"        < -   Where to truncate line if too long.  Default is at the start.
"              No width fields allowed.
"        = -   Separation point between left and right aligned items.
"              No width fields allowed.
"        # -   Set highlight group.  The name must follow and then a # again.
"              Thus use %#HLname# for highlight group HLname.  The same
"              highlighting is used, also for the statusline of non-current
"              windows.
"        * -   Set highlight group to User{N}, where {N} is taken from the
"              minwid field, e.g. %1*.  Restore normal highlight with %* or %0*.
"              The difference between User{N} and StatusLine  will be applied
"              to StatusLineNC for the statusline of non-current windows.
"              The number N must be between 1 and 9.  See |hl-User1..9|

"set statusline=%a\ %t\ %m%r%h%w\ \|\ %{&fileformat}\:%{&encoding}\:%Y\ %-10.(%b\(%B\)%)%-14.(%l,%c-%v%)\ %3p%%

