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
    touch '~/.vim/undodir'
fi

if [ ! -d ~/scripts ]
then
    ln -s "$DIR/scripts" ~/scripts
fi

if [ ! -f ~/.tmux.conf ]
then
    ln -s "$DIR/tmux.conf" ~/.tmux.conf
fi

# Mac specific setup
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    # Symlink vim to macvim
    if [ -x /usr/local/bin/mvim ]
    ln -s /usr/local/bin/mvim /usr/local/bin/vim
fi
