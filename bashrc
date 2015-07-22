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

if [ -f "$(dirname $0)/functions.sh" ]; then
    source "$(dirname $0)/functions.sh"
fi


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


function vim-process-swap {
    local swapfile_first=0
    while true; do
        case "$1" in
            ""|-h|--help)
                echo "usage: vim-process-swap file [swapfile [recoverfile]]" >&2
                return 1;;
            -s)
                shift
                swapfile_first=1;;
            *)
                break;;
        esac
    done
    local realfile=`readlink -f "$1"`
    local path=`dirname "$realfile"`
    local realname=`basename "$realfile"`
    if [ $swapfile_first -eq 1 ]; then
        local swapfile=$realfile
        realname=${realname:1:-4}
        realfile="${path}/${realname}"
    else
        local swapfile=${2:-"${path}/.${realname}.swp"}
    fi
    local recoverfile=${3:-"${path}/${realname}-recovered"}
    local lastresort=0
    for f in "$realfile" "$swapfile"; do
        if [ ! -f "$f" ]; then
            echo "File $f does not exist." >&2
            return 1
        elif fuser "$f"; then
            echo "File $f in use by process." >&2
            return 1
        fi
    done
    if [ -f "$recoverfile" ]; then
        echo "Recover file $recoverfile already exists. Delete existing recover file first." >&2
        return 1
    fi
    vim -u /dev/null --noplugin -r "$swapfile" -c ":wq $recoverfile"
    if cmp -s "$realfile" "$recoverfile"; then
        rm "$swapfile" "$recoverfile"
    elif [ "$realfile" -nt "$swapfile" ] && [ `stat -c%s "$realfile"` -gt `stat -c%s "$recoverfile"` ]; then
        echo "Swapfile is older than realfile, and recovered file is smaller than realfile"
        if _prompt_yn "Delete recovered file and swapfile without doing diff?"; then
            rm "$swapfile" "$recoverfile"
        else
            lastresort=1
        fi
    else
        lastresort=1
    fi
 
    if [[ "$lastresort" -ne 0 ]]; then
        rm "$swapfile"
        vimdiff "$recoverfile" "$realfile"
        if _prompt_yn "Delete recovered file?"; then
            rm "$recoverfile"
        fi
    fi
 
}