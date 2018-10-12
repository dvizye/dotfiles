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

# Aliases for ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cl=changeDirectory
function changeDirectory {
    cd $1 ; ls
}

if [[ $PROFILE_SHELL = "zsh" ]]; then
    alias rebash='source ~/.zshrc'
else
    [[ $PLATFORM = "mac" ]] && alias rebash="source ~/.bash_profile" || 
    alias rebash="source ~/.bashrc"
fi

[[ -f ~/.bookmarks ]] && alias book="source ~/.bookmarks"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
[[ -f $DIR/google_aliases.sh ]] && source "$DIR/google_aliases.sh"

alias ..='cl ..'

alias ff='find . -iname'
# ssh into GCE instance w/ gpu
alias gpu='gcloud compute --project "tf-box-217802" ssh --zone "asia-east1-a" "instance-2"'

# Helper functions
function changeDirectory {
    cd $1 ; ls
}

function fd {
    find . -name $1 -type d
}

# Machine/Application specific
alias robocode='~/robocode/robocode.sh'

# Mac-specific aliases
# (this is in addition to the script for mvim in order to get tmux to recognize that vim is running)
unamestr=`uname`
# if [[ "$unamestr" == 'Darwin' ]]; then
#     alias vim='DYLD_FORCE_FLAT_NAMESPACE=1 mvim -v'
# fi
alias tmux='TERM=screen-256color-bce tmux'

# Bazel aliases
alias bb='bazel build'
alias br='bazel run'
alias bt='bazel test'
alias bba='bazel build --config=away'
alias bra='bazel run --config=away'
alias bta='bazel test --config=away'
alias bt_valgrind='bazel test --run_under=valgrind'
alias br_valgrind='bazel_run --run_under=valgrind'

# Arc (Phabricator) aliases
alias aland='arc land --revision'

# Point vim to vim.gnome
alias vim='vim.gnome'

# Bookmarks
export AV="$HOME/av"

# Git aliases
alias gd='git diff'
alias gs='git status'
