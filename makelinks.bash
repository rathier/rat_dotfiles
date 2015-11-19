#!/usr/bin/env bash
############################
# wie in http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/ gelesen

# dotfiles directory
dir=~/rat_dotfiles
# old dotfiles backup directory
olddir=~/dotfiles_old
# list of files/folders to symlink in homedir
files="bashrc vimrc screenrc tmux.conf Xresources"

setup_vundle() {
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +BundleInstall
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
    # -f tests for regular file, -h test for symbolic link
    if [ -f ~/.$file -a ! -h ~/.$file ]; then
        echo "Move .$file from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    setup_vundle
fi

