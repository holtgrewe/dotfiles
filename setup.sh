#!/bin/bash -e

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Will create ~/dotfiles_backup and move your old dotfiles there"

set -x

mkdir ~/dotfiles_backup || { echo "Could not create ~/dotfiles_backup"; exit 1; }

mv -i -b ~/.vimrc ~/dotfiles_backup
mv -i -b ~/.vim ~/dotfiles_backup

ln -sr ${HERE}/vimrc ~/.vimrc
ln -sr ${HERE}/vim ~/.vim
