#!/usr/bin/env bash

# TODO: move these into an env file.
POWERLEVEL10K_INSTALL_PATH=~/powerlevel10k
FZF_INSTALL_PATH=~/.fzf

# Get my dotfiles.
[[ ! -d ~/.dotfiles ]] && git clone https://github.com/subie/dotfiles.git ~/.dotfiles

sudo apt-get update

# symlink dotfiles.
sudo apt-get -y install stow
(cd ~/.dotfiles/ && stow .)

# Setup zsh.
sudo apt-get -y install zsh
[[ ! -d ${POWERLEVEL10K_INSTALL_PATH} ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${POWERLEVEL10K_INSTALL_PATH}
chsh -s $(which zsh)
[[ ! -d ${FZF_INSTALL_PATH} ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_INSTALL_PATH}
[[ ! -f ~/.fzf.zsh ]] && ${FZF_INSTALL_PATH}/install

# tmux stuff.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
python3 -m pip install --user libtmux

# mosh (with true color).
if [ "$(mosh --version | head -1 | cut -d" " -f2)" != "1.4.0" ]; then
    sudo apt-get -y install protobuf-compiler
    wget https://github.com/mobile-shell/mosh/releases/download/mosh-1.4.0/mosh-1.4.0.tar.gz
    tar -xvf mosh-1.4.0.tar.gz
    cd mosh-1.4.0
    ./configure
    sudo make install
fi
