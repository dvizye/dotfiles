#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR

# Backup preexisting vim settings then setup vim.
git submodule init;
git submodule update;

if [[ -f ~/.vimrc ]]; then
  mv ~/.vimrc $DIR/preexisting_configs/vimrc
fi

if [[ -d ~/.vim ]]; then
  mv ~/.vim $DIR/preexisting_configs/vim
fi

$DIR/vim/setup.sh

# Backup preexisting tmux conf and replace.
if [[ -f ~/.tmux.conf ]]; then
  mv ~/.tmux.conf $DIR/preexisting_configs/tmux.conf
fi
ln -s $DIR/tmux/tmux.conf $HOME/.tmux.conf

# Backup preexisting bashrc and replace.
if [[ -f ~/.bashrc ]]; then
  mv ~/.bashrc $DIR/preexisting_configs/bashrc
fi
ln -s $DIR/bashrc $HOME/.bashrc

# Backup preexisting bash_profile and replace.
if [[ -f ~/.bash_profile ]]; then
  mv ~/.bash_profile $DIR/preexisting_configs/bash_profile
fi
ln -s $DIR/bash_profile $HOME/.bash_profile

# Backup git config and replace.
if [[ -f ~/.gitconfig ]]; then
  mv ~/.gitconfig $DIR/preexisting_configs/gitconfig
fi
ln -s $DIR/gitconfig ~/.gitconfig

if [[ -d ~/.git_template ]]; then
  mv ~/.git_template $DIR/preexisting_configs/git_template
fi
ln -s $DIR/git_template ~/.git_template

# Scripts
if [[ -d ~/scripts ]]; then
  mv ~/scripts $DIR/preexisting_configs/scripts
fi
ln -s $DIR/scripts ~/scripts
