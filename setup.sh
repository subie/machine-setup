#!/usr/bin/env bash

# TODO: move these into an env file.
POWERLEVEL10K_INSTALL_PATH=~/powerlevel10k
FZF_INSTALL_PATH=~/.fzf
PYENV_INSTALL_PATH=~/.pyenv
PYENV_SETUP_PYTHON_VERSION=3.9.16

# Get my dotfiles.
[[ ! -d ~/.dotfiles ]] && git clone https://github.com/subie/dotfiles.git ~/.dotfiles

# symlink dotfiles.
sudo apt-get -y install stow
(cd .dotfiles/ && stow .)

# Setup zsh.
sudo apt-get -y install zsh
[[ ! -d ${POWERLEVEL10K_INSTALL_PATH} ]] && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${POWERLEVEL10K_INSTALL_PATH}
chsh -s $(which zsh)
[[ ! -d ${FZF_INSTALL_PATH} ]] && git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_INSTALL_PATH}
[[ ! -f ~/.fzf.zsh ]] && ${FZF_INSTALL_PATH}/install

# Install pyenv and recentish python version.
sudo apt-get -y install libssl-dev
[[ ! -d ${PYENV_INSTALL_PATH} ]] && git clone https://github.com/pyenv/pyenv.git ${PYENV_INSTALL_PATH}
eval "$(${PYENV_INSTALL_PATH}/bin/pyenv init)"
${PYENV_INSTALL_PATH}/bin/pyenv install ${PYENV_SETUP_PYTHON_VERSION}
${PYENV_INSTALL_PATH}/versions/3.9.16/bin/pip install powerline-status