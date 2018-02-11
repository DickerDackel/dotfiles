cryptpass () {
    if [ $# == 0 ]; then
	perl -lne 'print crypt("$_", join "", (".", "/", 0..9, "A".."Z", "a".."z")[rand 64, rand 64])'
    else
	for i in "$@"; do
	    perl -le "print crypt('$i', join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64])"
	done
    fi
}

