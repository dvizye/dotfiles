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
# alias vim='DYLD_FORCE_FLAT_NAMESPACE=1 mvim -v'

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
