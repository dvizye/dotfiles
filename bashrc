# If not running interactively, don't do anything
[ -z "$PS1" ] && return

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
if [ -f "$DIR/aliases.sh" ]; then
    source "$DIR/aliases.sh"
fi

# Add scripts to path
export PATH=~/scripts:/usr/local/bin:/opt/local/bin:$PATH

# Set OS-specific ls colors.
[[ $PLATFORM = "mac" ]] && export CLICOLOR=1 &&
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
if [[ $PLATFORM = "linux" ]]; then
  export LS_OPTIONS='--color=auto'
  eval "$(dircolors -b)"
  alias ls='ls $LS_OPTIONS'
fi

# Setup OpenCV
export PYTHONPATH=~/Projects/opencv/build/lib:$PYTHONPATH

# Virtualenvwrapper
export WORKON_HOME=$HOME/virtualenvs
export PROJECT_HOME=$HOME/Projects
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
fi

function vim-process-swap {
    $DIR/bash_functions/vim-process-swap.sh $1
}

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# source any remaining machine-specific configs
if [ -f "$DIR/machine_specific/bashrc" ];
  then source "$DIR/machine_specific/bashrc";
fi

# Show git branch in PS1.
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
