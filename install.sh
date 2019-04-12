#!/usr/bin/env bash

set -o errexit

DOTFILES_SRC_DIR="$PWD/home/"
DOTFILES_DST_DIR="$HOME"
BACKUP_DIR="$DOTFILES_DST_DIR/.dotfiles.backup"

has_backup=

if [ ! -d "$DOTFILES_SRC_DIR" ]; then
  >&2 echo "Cannot find $DOTFILES_SRC_DIR. Pleas run the script under dotfiles/ repo."
  exit 1
fi

# Use -mindepth 1 to exclude "$DOTFILES_SRC_DIR" itself.
for path in $(find "$DOTFILES_SRC_DIR" -mindepth 1 -maxdepth 2); do
  dst_path="$DOTFILES_DST_DIR/${path##*/}"
  if [ -e "$dst_path" ] || [ -L "$dst_path" ]; then
    mkdir -p "$BACKUP_DIR"
    mv --backup=numbered "$dst_path" -t "$BACKUP_DIR/"
    has_backup=1
  fi
  ln -s -t "$DOTFILES_DST_DIR" "$path"
done

[ -n "$has_backup" ] && echo "Original dotfiles backed up to $BACKUP_DIR."