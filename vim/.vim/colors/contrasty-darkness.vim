" Vim color file
" Maintainer:  Markus Weimar <mail@markusweimar.de>
" Last Change: 2021-05-07
" URL:         https://www.markusweimar.de/

set background=dark
if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

set t_Co=256
let g:colors_name="contrasty-darkness"

" Editor settings
hi Normal       ctermfg=15 ctermbg=0 cterm=none guifg=#ffffff guibg=#000000 gui=NONE
hi Cursor       ctermfg=none ctermbg=none cterm=standout guifg=NONE guibg=NONE gui=reverse
hi CursorLine   ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
hi LineNr       ctermfg=2 ctermbg=none cterm=none guifg=#22ff00 guibg=NONE gui=NONE
hi CursorLineNR ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE

" Number column
hi CursorColumn ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi FoldColumn   ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi SignColumn   ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi Folded       ctermfg=3 ctermbg=0 cterm=italic guifg=#ffcc00 guibg=#000000 gui=italic

" Window/Tab delimiters
hi VertSplit   ctermfg=15 ctermbg=0 cterm=bold guifg=#ffffff guibg=#000000 gui=bold
" See section “colorcolumn workaround” below
hi ColorColumn ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
hi TabLine     ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi TabLineFill ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi TabLineSel  ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE

" File Navigation / Searching
hi Directory ctermfg=3 ctermbg=none cterm=bold guifg=#ffcc00 guibg=NONE gui=bold
hi Search    ctermfg=none ctermbg=4 cterm=none guifg=NONE guibg=#1a66ff gui=NONE
hi IncSearch ctermfg=none ctermbg=4 cterm=none guifg=NONE guibg=#1a66ff gui=NONE

" Prompt/Status
hi StatusLine   ctermfg=15 ctermbg=0 cterm=bold guifg=#ffffff guibg=#000000 gui=bold
hi StatusLineNC ctermfg=15 ctermbg=0 cterm=none guifg=#ffffff guibg=#000000 gui=NONE
hi WildMenu     ctermfg=none ctermbg=4 cterm=none guifg=NONE guibg=#1a66ff gui=NONE
hi Question     ctermfg=2 ctermbg=none cterm=bold guifg=#22ff00 guibg=NONE gui=bold
hi Title        ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE
hi ModeMsg      ctermfg=2 ctermbg=none cterm=bold guifg=#22ff00 guibg=NONE gui=bold
hi MoreMsg      ctermfg=2 ctermbg=none cterm=bold guifg=#22ff00 guibg=NONE gui=bold

" Visual aid
hi MatchParen ctermfg=none ctermbg=4 cterm=none guifg=NONE guibg=#1a66ff gui=NONE
hi Visual     ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
hi VisualNOS  ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
hi NonText    ctermfg=3 ctermbg=none cterm=bold guifg=#ffcc00 guibg=NONE gui=bold

hi Todo       ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Underlined ctermfg=none ctermbg=none cterm=underline guifg=NONE guibg=NONE gui=underline
hi Error      ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi ErrorMsg   ctermfg=1 ctermbg=none cterm=bold guifg=#ff7c4d guibg=NONE gui=bold
hi WarningMsg ctermfg=1 ctermbg=none cterm=bold guifg=#ff7c4d guibg=NONE gui=bold
hi Ignore     ctermfg=none ctermbg=7 cterm=bold guifg=NONE guibg=#888888 gui=bold
hi SpecialKey ctermfg=3 ctermbg=none cterm=bold guifg=#ffcc00 guibg=NONE gui=bold

" Variable types
hi Constant        ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi String          ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi StringDelimiter ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi Character       ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi Number          ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE
hi Boolean         ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Float           ctermfg=1 ctermbg=none cterm=none guifg=#ff7c4d guibg=NONE gui=NONE

hi Identifier ctermfg=2 ctermbg=none cterm=none guifg=#22ff00 guibg=NONE gui=NONE
hi Function   ctermfg=2 ctermbg=none cterm=none guifg=#22ff00 guibg=NONE gui=NONE

" Language constructs
hi Statement   ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Conditional ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Repeat      ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Label       ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Operator    ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Keyword     ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Exception   ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Comment     ctermfg=3 ctermbg=none cterm=none guifg=#ffcc00 guibg=NONE gui=NONE

hi Special        ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi SpecialChar    ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Tag            ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Delimiter      ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi SpecialComment ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE
hi Debug          ctermfg=6 ctermbg=none cterm=none guifg=#00ffff guibg=NONE gui=NONE

" C like
hi PreProc   ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Include   ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Define    ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Macro     ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi PreCondit ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE

hi Type         ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi StorageClass ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Structure    ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE
hi Typedef      ctermfg=5 ctermbg=none cterm=none guifg=#ff61df guibg=NONE gui=NONE

" Diff
hi DiffAdd    ctermfg=0 ctermbg=2 cterm=none guifg=#000000 guibg=#22ff00 gui=NONE
hi DiffChange ctermfg=0 ctermbg=3 cterm=none guifg=#000000 guibg=#ffcc00 gui=NONE
hi DiffDelete ctermfg=0 ctermbg=1 cterm=none guifg=#000000 guibg=#ff7c4d gui=NONE
hi DiffText   ctermfg=0 ctermbg=5 cterm=none guifg=#000000 guibg=#ff61df gui=NONE
if &diff
  hi MatchParen cterm=none ctermbg=none ctermfg=none
endif

" Completion menu
hi Pmenu      ctermfg=0 ctermbg=2 cterm=bold guifg=#000000 guibg=#006607 gui=bold
hi PmenuSel   ctermfg=15 ctermbg=4 cterm=bold guifg=#ffffff guibg=#1a66ff gui=bold
hi PmenuSbar  ctermfg=none ctermbg=7 cterm=bold guifg=NONE guibg=#888888 gui=bold
hi PmenuThumb ctermfg=none ctermbg=0 cterm=bold guifg=NONE guibg=#000000 gui=bold

" Spelling
hi SpellBad   ctermfg=1 ctermbg=none cterm=underline guifg=#ff7c4d guibg=NONE gui=underline
hi SpellCap   ctermfg=5 ctermbg=none cterm=underline guifg=#ff61df guibg=NONE gui=underline
hi SpellLocal ctermfg=3 ctermbg=none cterm=underline guifg=#ffcc00 guibg=NONE gui=underline
hi SpellRare  ctermfg=6 ctermbg=none cterm=underline guifg=#00ffff guibg=NONE gui=underline

" Plugin EasyMotion
hi EasyMotionTarget        ctermfg=0 ctermbg=4 cterm=bold guifg=#000000 guibg=#1a66ff gui=bold
hi EasyMotionTarget2First  ctermfg=0 ctermbg=4 cterm=bold guifg=#000000 guibg=#1a66ff gui=bold
hi EasyMotionTarget2Second ctermfg=0 ctermbg=7 cterm=bold guifg=#000000 guibg=#888888 gui=bold
hi EasyMotionShade         ctermfg=none ctermbg=none cterm=none guifg=NONE guibg=NONE gui=NONE

" colorcolumn workaround
" 'colorcolumn' highlights an incorrect column when using 'wrap' in a buffer
" that is narrower than 'colorcolumn'. This workaround hides it in buffers
" that are too narrow.
autocmd BufEnter,VimResized * call SetColorColumnColor()
function! SetColorColumnColor()
  if winwidth(0) - &numberwidth - &colorcolumn - 1 <= 0
    hi ColorColumn ctermfg=15 ctermbg=0 cterm=none guifg=#ffffff guibg=#000000 gui=NONE
  else
    hi ColorColumn ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
  endif
endfunction!

" colorcolumn workaround
" 'colorcolumn' highlights an incorrect column when using 'wrap' in a buffer
" that is narrower than 'colorcolumn'. This workaround replaces Vim’s
" colorcolumn with a fixed one. Only enabled with 'expandtab' due to being
" incompatible with tabs.
"hi TrueColorColumn ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
"autocmd FileType * if &colorcolumn && &expandtab | exec 'match TrueColorColumn /^.\{' . (&colorcolumn - 1) . '\}\zs.\ze.*$/' | endif
"autocmd BufEnter,VimResized * call SetColorColumnColor()
"function! SetColorColumnColor()
"  if winwidth(0) - &numberwidth - &colorcolumn - 1 <= 0
"    hi ColorColumn ctermfg=15 ctermbg=0 cterm=none guifg=#ffffff guibg=#000000 gui=NONE
"  else
"    hi ColorColumn ctermfg=none ctermbg=7 cterm=none guifg=NONE guibg=#888888 gui=NONE
"  endif
"endfunction!
