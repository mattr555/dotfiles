backup=~/dotfiles_old
dir=~/dotfiles
files="muttrc tmux.conf vimrc vim Xmodmap bashrc todo todo.actions.d"

mkdir -p $backup
for file in $files; do
	mv ~/.$file $backup/$file
	ln -s $dir/$file ~/.$file
done

binfiles="irc"
for file in $files; do
	mv ~/bin/$file $backup/bin/$file
	ln -s $dir/bin/$file ~/bin/$file
done

echo "symlink creation done"
