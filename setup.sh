#!/usr/bin/env bash

# TODO: make these steps idempotent for rerunning after errors.

# TODO: move these into an env file.
POWERLEVEL10K_INSTALL_PATH=~/powerlevel10k
FZF_INSTALL_PATH=~/.fzf
PYENV_INSTALL_PATH=~/.pyenv
PYENV_SETUP_PYTHON_VERSION=3.9.16

# Get my dotfiles.
git clone https://github.com/subie/dotfiles.git ~/.dotfiles

# symlink dotfiles.
sudo apt-get -y install stow
stow --dir=~/.dotfiles --target=~/

# Setup zsh.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${POWERLEVEL10K_INSTALL_PATH}
chsh -s $(which zsh)
git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_INSTALL_PATH}
${FZF_INSTALL_PATH}/install

# Install pyenv and recentish python version.
git clone https://github.com/pyenv/pyenv.git ${PYENV_INSTALL_PATH}
eval "$(${PYENV_INSTALL_PATH}/bin/pyenv init --path)"
${PYENV_INSTALL_PATH}/bin/pyenv install ${PYENV_SETUP_PYTHON_VERSION}
${PYENV_INSTALL_PATH}/bin/pyenv shell ${PYENV_SETUP_PYTHON_VERSION}
pip install powerline-status

# TODO: install emacs
