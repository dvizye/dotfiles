DIR=$( cd "$( dirname "$0" )" && pwd )
if [ ! -f ~/.gitconfig ]
then
    ln -s "$DIR/gitconfig" ~/.gitconfig
    ln -s "$DIR/git_template" ~/.git_template
fi
if [ ! -f ~/.zshrc ]
then
    ln -s "$DIR/zshrc" ~/.zshrc
    ln -s "$DIR/zshrc.mine" ~/.zshrc.mine
    ln -s "$DIR/zshrc.mac" ~/.zshrc.mac
fi

if [ ! -f ~/.vim/undodir ]
then
    mkdir "$HOME/.vim/undodir"
fi

if [ ! -d ~/scripts ]
then
    ln -s "$DIR/scripts" ~/scripts
fi

if [ ! -f ~/.tmux.conf ]
then
    ln -s "$DIR/tmux/tmux.conf" ~/.tmux.conf
    mkdir "$HOME/.tmux"
    ln -s "$DIR/tmux/dev_env" ~/.tmux/dev_env
fi

# Mac specific setup
unamestr=`uname`
if [ "$unamestr" == 'Darwin' ]; then
    # Change vim to mvim
    if [ -x /usr/local/bin/mvim ]; then
        echo 'DYLD_FORCE_FLAT_NAMESPACE=1 mvim -v $1' > /usr/local/bin/vim
        chmod +x /usr/local/bin/vim
    fi
fi
