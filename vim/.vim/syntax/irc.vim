" Vim syntax file
" Language:	MoinMoin
" Maintainer:	Michael Lamertz <mike@perl-ronin.de>
" Last Change:	$Id: moin.vim,v 1.4 2005/04/28 08:14:19 mlamertz Exp $

" Bugs:		Parsing of mixed bold-italic not yet implemented
" 		Tables not yet implemented

if version <600
    syntax clear
elsif exists("b:current_syntax")
    finish
endif

syn clear
hi clear

syn match	ircTimestamp		/^[0-9]\{2}:[0-9]\{2}:[0-9]\{2}/
syn match	ircNick			/<[^>]\+>/
syn match	ircStatus		/-!-.*$/
syn match	ircHighlight		/\*[^*]\+\*/
syn match	ircAction		/\* .*$/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_acedb_syn_inits")
    if version < 508
	let did_acedb_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif

    HiLink	ircTimestamp		LineNr
    HiLink	ircNick			Identifier
    HiLink	ircStatus		Comment
    HiLink	ircAction		String
    HiLink	ircHighlight		String
  delcommand HiLink
endif

let b:current_syntax = "irc"
