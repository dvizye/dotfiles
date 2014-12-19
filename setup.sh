DIR=$( cd "$( dirname "$0" )" && pwd )
if [ ! -f ~/.gitconfig ]
then
    ln -s "$DIR/gitconfig" "~/.gitconfig"
fi

ln -s "$DIR/zshrc.mac" ~/zshrc.mac
