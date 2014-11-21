if [ ! -f ~/.gitconfig ]
then
    ln -s $(dirname $0)/gitconfig ~/.gitconfig 
fi
