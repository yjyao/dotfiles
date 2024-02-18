#!/usr/bin/env bash

SOURCE_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Stow all folders.
(cd "$SOURCE_DIR"; stow --no-folding -R */ -t "$HOME")

# Generate `jj` config file.
bash ~/.config/jj/scripts/gen_config.sh
