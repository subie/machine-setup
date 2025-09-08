#!/usr/bin/env bash

# TODO: move these into an env file.
POWERLEVEL10K_INSTALL_PATH=~/powerlevel10k
FZF_INSTALL_PATH=~/.fzf

# Get my dotfiles.
[[ ! -d ~/.dotfiles ]] && git clone https://github.com/subie/dotfiles.git ~/.dotfiles

sudo apt-get update
sudo apt-get install ispell

# symlink dotfiles.
sudo apt-get -y install stow
(cd ~/.dotfiles/ && stow .)

# Setup zsh.
sudo apt-get -y install zsh
[[ ! -d ${POWERLEVEL10K_INSTALL_PATH} ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${POWERLEVEL10K_INSTALL_PATH}
sudo chsh -s $(which zsh) $(whoami)
[[ ! -d ${FZF_INSTALL_PATH} ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_INSTALL_PATH}
[[ ! -f ~/.fzf.zsh ]] && ${FZF_INSTALL_PATH}/install

# tmux stuff.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
python3 -m pip install --user libtmux

sudo apt-get install mosh

# Copilot stuff.
sudo apt-get install npm
sudo npm install -g @github/copilot-language-server --prefix /usr/local
# On Ubuntu 20.04, the best way to install nodejs 20 is to use snap.
sudo snap install node --channel=20/stable --classic
sudo mv /usr/bin/node /usr/bin/node_old
sudo ln -s /snap/bin/node /usr/bin/node

timedatectl set-timezone "America/Los_Angeles"
