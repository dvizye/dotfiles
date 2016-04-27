#!/bin/sh

# Detect platform
PLATFORM="unknown"
case "$(uname -s)" in
   Darwin)
     PLATFORM="mac"
     ;;
   Linux)
     PLATFORM="linux"
     ;;
   CYGWIN*|MINGW32*|MSYS*)
     PLATFORM="windows"
     ;;
   *)
     echo "Error: Could not detect OS"
     ;;
esac

# Get script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get shell type
if test -n "$ZSH_VERSION"; then
  PROFILE_SHELL=zsh
elif test -n "$BASH_VERSION"; then
  PROFILE_SHELL=bash
elif test -n "$KSH_VERSION"; then
  PROFILE_SHELL=ksh
elif test -n "$FCEDIT"; then
  PROFILE_SHELL=ksh
elif test -n "$PS3"; then
  PROFILE_SHELL=unknown
else
  PROFILE_SHELL=sh
fi

# Set up git configuration
if [[ ! -e ~/.gitconfig ]]
then
    ln -s "$DIR/gitconfig" ~/.gitconfig
    ln -s "$DIR/git_template" ~/.git_template
    echo "Set up git config"
else
    echo "Git configuration already exists"
fi

# Set up bash
if [[ "$PROFILE_SHELL" = "bash" ]]
then
    [[ -e "$HOME/.bash_profile" ]] && eval "$(mv $HOME/.bash_profile $HOME/.bash_profile.orig)"
    [[ -e "$HOME/.bashrc" ]] && eval "$(mv $HOME/.bashrc $HOME/.bashrc.orig)"
	if [[ $PLATFORM = "mac" ]]
	then
        echo "[[ -e $HOME/.bash_profile.orig ]] &&
            source $HOME/.bash_profile.orig \n 
            source ${DIR}/bashrc" > "$HOME/.bash_profile"
		echo "Linked bash_profile"
	elif [[ $PLATFORM = "linux" ]]
	then
        echo "[[ -e $HOME/.bashrc.orig ]] &&
            source $HOME/.bashrc.orig \n 
            source ${DIR}/bashrc" > "$HOME/.bashrc"
		echo "Linked bashrc"
	else
		echo "Did not link bashrc or bash_profile; Do they already exist?"
	fi
fi

# Set up zsh
if [[ "$PROFILE_SHELL" = "zsh" ]]
then
	if [ ! -f ~/.zshrc ]
	then
	    ln -s "$DIR/zshrc" ~/.zshrc
	    ln -s "$DIR/zshrc.mine" ~/.zshrc.mine
	    ln -s "$DIR/zshrc.mac" ~/.zshrc.mac
	    echo "Set up zsh"
	else 
	    echo "Zsh configuration already exists"
	fi
fi

if [ ! -d ~/scripts ]
then
    ln -s "$DIR/scripts" ~/scripts
fi

if [ ! -e ~/.tmux.conf ]
then
    ln -s "$DIR/tmux/tmux.conf" ~/.tmux.conf
    mkdir "$HOME/.tmux"
    ln -s "$DIR/tmux/dev_env" ~/.tmux/dev_env
    echo "Set up tmux configuration"
else
    echo "Tmux configuration already exists"
fi

# Mac specific setup
# unamestr=`uname`
# if [ "$unamestr" == 'Darwin' ]; then
#     # Change vim to mvim
#    if [ -x /usr/local/bin/mvim ]; then
#        echo 'DYLD_FORCE_FLAT_NAMESPACE=1 mvim -v $1' > /usr/local/bin/vim
#        chmod +x /usr/local/bin/vim
#    fi
# fi
