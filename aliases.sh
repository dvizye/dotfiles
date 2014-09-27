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

# Application specific aliases
if [ -x /Applications/MATLAB_R2013b.app/bin/matlab ]
then
    alias matlab='/Applications/MATLAB_R2013b.app/bin/matlab'
fi

alias vim='mvim -v'

# Helper functions
function changeDirectory {
    cd $1 ; ls
}
