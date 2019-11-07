#!/usr/bin/env bash

set -o errexit

DOTFILES_SRC_DIR="$PWD/home/"
DOTFILES_DST_DIR="$HOME"
BACKUP_DIR="$DOTFILES_DST_DIR/.dotfiles.backup"

has_backup=

if [[ ! $SHELL =~ .*bash ]]; then
  >&2 echo "These dotfiles are for bash only; You are running $SHELL."
  exit 1
fi

if [ ! -d "$DOTFILES_SRC_DIR" ]; then
  >&2 echo "Cannot find $DOTFILES_SRC_DIR. Pleas run the script under dotfiles/ repo."
  exit 1
fi

# Use -mindepth 1 to exclude "$DOTFILES_SRC_DIR" itself.
for path in $(find "$DOTFILES_SRC_DIR" -mindepth 1 -maxdepth 1); do
  dst_path="$DOTFILES_DST_DIR/${path##*/}"
  if [ $(readlink -f "$dst_path") != "$path" ]; then
    if [ -e "$dst_path" ]; then
      mkdir -p "$BACKUP_DIR"
      mv --backup=numbered "$dst_path" -t "$BACKUP_DIR/"
      has_backup=1
    fi
    ln -s -t "$DOTFILES_DST_DIR" "$path"
  fi
done

[ -n "$has_backup" ] && echo "Original dotfiles backed up to $BACKUP_DIR."

read -p "Would you like to install Vundle, the package manager for Vim? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ [Yy] ]]; then
  if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
  vim +PluginInstall +qall
fi
