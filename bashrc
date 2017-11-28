# Vim keybindings
# set -o vi

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

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd "$( dirname "${SOURCE}" )" && pwd )"
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# if [ -f "$DIR/functions.sh" ]; then
#     source "$DIR/functions.sh"
# fi


if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
fi

# Show line number; oh-my-zsh has the other GREP_OPTIONS I want
# export GREP_OPTIONS="$GREP_OPTIONS -n"

# Add scripts to path
export PATH=~/scripts:/usr/local/bin:/opt/local/bin:$PATH

# Set ls colors for mac
[[ $PLATFORM = "mac" ]] && export CLICOLOR=1 &&
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [ -d /opt/gurobi602/linux64 ]; then
    export GUROBI_HOME=/opt/gurobi602/linux64
    export PATH="${PATH}:${GUROBI_HOME}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib/:${GUROBI_HOME}/lib"
fi

# Setup OpenCV
export PYTHONPATH=~/Projects/opencv/build/lib:$PYTHONPATH

# Setup trajopt
if [ -d /home/dzy/trajopt ]  && [ -d /home/dzy/build_trajopt/lib ]; then
    export PYTHONPATH=~/trajopt:~/build_trajopt/lib:$PYTHONPATH
    # export PYTHONPATH=/home/dzy/trajopt:/home/dzy/trajopt/build_trajopt/lib:$PYTHONPATH
fi

export DOT="$HOME/dotfiles"
export REF="$HOME/Dropbox/Reference_Sheets"
export SCRATCH="$HOME/Dropbox/Projects/Scratch"
export JOURNAL="$HOME/Dropbox/Projects/Journal"

# Virtualenvwrapper
export WORKON_HOME=$HOME/virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

function vim-process-swap {
    $DIR/bash_functions/vim-process-swap.sh $1
}

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export SCALA_HOME=/opt/scala
export PATH=$PATH:$SCALA_HOME/bin
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# source any remaining machine-specific configs
if [ -f "$DIR/bashrc.machine_specific" ];
  then source "$DIR/bashrc.machine_specific";
fi
