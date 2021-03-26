# Set paths to dotfiles dir.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source machine specific aliases
if [[ -f $DIR/machine_specific/aliases.sh ]]; then
  source $DIR/machine_specific/aliases.sh
fi

# Rebash
alias rebash='source $DIR/bashrc'

# Aliases for ls.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cl=changeDirectory
function changeDirectory {
    cd $1 ; ls
}
alias ..='cl ..'

# Aliases for find.
alias ff='find . -iname'
function ffd {
  cd $(dirname $(find . -iname $1 | head -n 1))
}
function fd {
    find . -name $1 -type d
}

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
alias land='arc land --revision'
alias lint='arc lint --apply-patches'

# Git aliases
alias gd='git diff'
alias gs='git status'
