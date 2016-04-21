# Aliases for ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cl=changeDirectory
function changeDirectory {
    cd $1 ; ls
}


alias rebash='source ~/.zshrc'

alias ..='cl ..'

alias ff='find . -iname'

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
