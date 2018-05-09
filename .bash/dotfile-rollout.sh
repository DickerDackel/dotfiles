dotfile-rollout () {
    rsync -ahHxP --delete .bash/ ~/.bash/
    rsync -ahHxP --delete .vim/ ~/.vim/
    for f in .*; do
	[[ -f "$f" ]] && cp $f ~/
    done
}
