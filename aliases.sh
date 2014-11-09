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
alias vim='mvim -v'

# Helper functions
function changeDirectory {
    cd $1 ; ls
}
