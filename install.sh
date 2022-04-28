

if [ $SHELL != "/bin/zsh" ]; then
    echo "use zsh as the default shell"
fi

if [ -d ~/.oh-my-zsh ]; then :; else
    echo "install oh-my-zsh"
fi

cp -n .oh-my-zsh/themes/mytheme.zsh-theme $HOME/.oh-my-zsh/themes/mytheme.zsh-theme

if [ "$REMOTE_CONTAINERS" = true ]; then # only in .devcontianer
    chsh -s /bin/zsh
else
    cp -n .gitconfig $HOME/.gitconfig
fi

if [ -e $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc_old-$(date "+%FT%T")
fi

cp .zshrc $HOME/.zshrc
