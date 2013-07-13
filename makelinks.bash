#!/usr/bin/env bash
############################
# wie in http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ gelesen

dir=~/rat_dotfiles           # dotfiles directory
olddir=~/dotfiles_old        # old dotfiles backup directory
files="bashrc vimrc screenrc tmux.conf" # list of files/folders to symlink in homedir

setup_vundle() {
    mkdir -p .vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
}

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    if [ -f ~/.$file ]; then
        echo "Move $file from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

[ ! -d ~/.vim/bundle/vundle ] && setup_vundle

