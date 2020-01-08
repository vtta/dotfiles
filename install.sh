#!/bin/zsh

# git clone https://github.com/vtta/dotfiles dotfiles
# cd dotfiles
# git submodule update --init --recursive

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}

stow --verbose --restow --target=${HOME} zsh tmux vscode
stow --verbose --restow --target=${XDG_CONFIG_HOME} nvim
# zsh ${XDG_CONFIG_HOME}/tmux/plugins/tpm/bin/install_plugins
