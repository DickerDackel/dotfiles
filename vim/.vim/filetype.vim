augroup filetypedetect
au BufNewFile,BufRead *.tt		setf tt2
au BufNewFile,BufRead *.tt2		setf tt2
au BufNewFile,BufRead *.dokuwiki	setf dokuwiki
au BufNewFile,BufRead *.wiki		setf moin
au BufNewFile,BufRead *.moin		setf moin
au BufNewFile,BufRead *.irc		setf irc
augroup END
