#!/bin/zsh

# git clone https://github.com/vtta/dotfiles dotfiles
# cd dotfiles
# git submodule update --init --recursive

stow --verbose --restow --target=${HOME}/.config nvim
stow --verbose --restow --target=${HOME} zsh