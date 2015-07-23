# Ported from bashrc

 #If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Setup commenting
setopt interactivecomments

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
if [ -f "$(dirname $0)/aliases.sh" ]; then
    source "$(dirname $0)/aliases.sh"
fi

# if [ -f "$(dirname $0)/functions.sh" ]; then
#     source "$(dirname $0)/functions.sh"
# fi


if [ -f ~/.bash_aliases.sh ]; then
    . ~/.bash_aliases.sh
fi

# Show line number; oh-my-zsh has the other GREP_OPTIONS I want
# export GREP_OPTIONS="$GREP_OPTIONS -n"

# Add scripts to path
export PATH=~/scripts:/usr/local/bin:/opt/local/bin:$PATH

DIR=$( cd "$( dirname "$0" )" && pwd )
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    source "$DIR/zshrc.mac"
fi

if [[ ! "$unamestr" == 'Darwin' ]]; then
    export OPENRAVE=`openrave-config --python-dir`/openravepy/_openravepy_/examples
    export VIMRUNTIME="/usr/share/vim/vim74"
fi


if [ -d /opt/gurobi602/linux64 ]; then
    export GUROBI_HOME=/opt/gurobi602/linux64
    export PATH="${PATH}:${GUROBI_HOME}/bin"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib/:${GUROBI_HOME}/lib"
fi

# Setup trajopt
if [ -d /home/dzy/trajopt ]  && [ -d /home/dzy/build_trajopt/lib ]; then
    export PYTHONPATH=~/trajopt:~/build_trajopt/lib:$PYTHONPATH
    # export PYTHONPATH=/home/dzy/trajopt:/home/dzy/trajopt/build_trajopt/lib:$PYTHONPATH
fi

export DOT="$HOME/dotfiles"
export VIM="$HOME/dotfiles/vim"
export REF="$HOME/Dropbox/Reference_Sheets"
export SCRATCH="$HOME/Dropbox/Projects/Scratch"
export JOURNAL="$HOME/Dropbox/Projects/Journal"

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Dropbox/Projects
source /usr/local/bin/virtualenvwrapper.sh


DIR=$( cd "$( dirname "$0" )" && pwd )
function vim-process-swap {
    $DIR/bash_functions/vim-process-swap.sh $1
}
