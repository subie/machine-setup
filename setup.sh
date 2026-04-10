#!/usr/bin/env bash
#
# Usage: ./setup.sh
# Work:  WORK_GITHUB_PAT=ghp_xxx WORK_DOTFILES_REPO=org/repo ./setup.sh

# TODO: move these into an env file.
POWERLEVEL10K_INSTALL_PATH=~/powerlevel10k
FZF_INSTALL_PATH=~/.fzf

# Get my dotfiles.
[[ ! -d ~/.dotfiles ]] && git clone https://github.com/subie/dotfiles.git ~/.dotfiles

sudo apt-get update
sudo apt-get install ispell

# symlink dotfiles.
sudo apt-get -y install stow
(cd ~/.dotfiles/ && stow --no-folding .)

# Work dotfiles (optional).
# Usage: WORK_GITHUB_PAT=ghp_xxx WORK_DOTFILES_REPO=org/repo ./setup.sh
if [[ -n "$WORK_DOTFILES_REPO" ]]; then
  if [[ -z "$WORK_GITHUB_PAT" ]]; then
    echo "Error: WORK_GITHUB_PAT is required when WORK_DOTFILES_REPO is set."
    exit 1
  fi
  [[ ! -d ~/.dotfiles-work ]] && git clone "https://${WORK_GITHUB_PAT}@github.com/${WORK_DOTFILES_REPO}.git" ~/.dotfiles-work
  (cd ~/.dotfiles-work/ && stow --no-folding .)
fi

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

# GPG + pass for credential storage (used by git-credential-manager).
sudo apt-get -y install pass pinentry-curses
if ! gpg --list-keys &>/dev/null; then
    echo "No GPG key found. Generate one with: gpg --gen-key"
    echo "Then initialize pass with: pass init <gpg-key-id>"
fi

# Copilot stuff.
sudo apt-get install npm
sudo npm install -g @github/copilot-language-server --prefix /usr/local
# On Ubuntu 20.04, the best way to install nodejs 20 is to use snap.
sudo snap install node --channel=20/stable --classic
sudo mv /usr/bin/node /usr/bin/node_old
sudo ln -s /snap/bin/node /usr/bin/node

sudo timedatectl set-timezone "America/Los_Angeles"
