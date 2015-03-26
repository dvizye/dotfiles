DIR=$( cd "$( dirname "$0" )" && pwd )
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

