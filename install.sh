#!/bin/sh

# git clone https://github.com/vtta/dotfiles dotfiles
# cd dotfiles
# git submodule update --init --recursive

git clone https://github.com/tarjoilija/zgen.git ${HOME}/.zgen

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

stow --verbose --restow --target=${HOME} zsh
# stow --verbose --restow --target=${XDG_CONFIG_HOME} nvim
# zsh ${XDG_CONFIG_HOME}/tmux/plugins/tpm/bin/install_plugins
