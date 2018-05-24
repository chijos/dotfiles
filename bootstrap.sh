#!/bin/sh

# Bootstrap a new dev machine --------------------------------------{{{
$DOTFILES_DIR=`dirname $0`

# Prompt for sudo password upfront
sudo -v

# Update package lists ---------------------------------------------{{{
sudo apt-get update
# }}}

# Installs ---------------------------------------------------------{{{

# utilities --------------------------------------------------------{{{
sudo apt-get install -y \
    curl \
    python2.7 \
    python-pip \
    python3 \
    python3-pip \
    most

# nodejs
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
# }}}

# zsh --------------------------------------------------------------{{{
sudo apt-get install -y zsh
chsh -s $(which zsh)
# }}}

# oh-my-zsh --------------------------------------------------------{{{
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# zsh-syntax-highlighting ------------------------------------------{{{
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/
# }}}

# zsh-syntax-highlighting ------------------------------------------{{{
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/
# }}}

# }}}

# pure prompt ------------------------------------------------------{{{
mkdir -p $HOME/.zsh/prompt/pure
curl https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh > $HOME/.zsh/prompt/pure/pure.zsh
curl https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh > $HOME/.zsh/prompt/pure/async.zsh
ln -s $HOME/.zsh/prompt/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s $HOME/.zsh/prompt/pure/async.zsh /usr/local/share/zsh/site-functions/async
# }}}

# fzf ---------------------------------------------------------------{{{
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install
# }}}

# neovim ------------------------------------------------------------{{{
sudo apt-get install -y neovim

# neovim packages
python -m pip install neovim
python3 -m pip3 install neovim
npm install --global neovim
# }}}

# vim-plug ----------------------------------------------------------{{{
mkdir -p $HOME/.vim/autoload
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > $HOME/.vim/autoload/plug.vim
mkdir -p $HOME/.local/share/nvim/site/autoload
cp $HOME/.vim/autoload/plug.vim $HOME/.local/share/nvim/site/autoload/
# }}}

# }}}

# tmux --------------------------------------------------------------{{{
sh $DOTFILES_DIR/install/tmux.sh
# }}}

# Symlink dotfiles --------------------------------------------------{{{
ln -s $DOTFILES_DIR/git/.gitconfig $HOME/.gitconfig
ln -s $DOTFILES_DIR/shell/.zshrc $HOME/.zshrc
ln -s $DOTFILES_DIR/vim/.vimrc $HOME/.vimrc
ln -s $DOTFILES_DIR/nvim/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES_DIR/tmux/.tmux.conf $HOME/.tmux.conf
# }}}

# Trigger install of all neovim plugins -----------------------------{{{
nvim -i NONE -c PlugInstall -c qa
# }}}

# Switch between Windows git and Linux git depending on location ----{{{
cp $DOTFILES_DIR/git/git /usr/local/bin/
# }}}

# source the .zshrc to apply all changes
source $HOME/.zshrc

# }}}
