backup=~/dotfiles_old
dir=~/dotfiles
files="muttrc tmux.conf vimrc vim Xmodmap bashrc"

mkdir -p $backup
for file in $files; do
	mv ~/.$file $backup/$file
	ln -s $dir/$file ~/.$file
done

echo "symlink creation done"
