#!/usr/bin/env bash

die() {
  >&2 echo "$@"
  exit 1
}

main() {
  command -v jj &>/dev/null || die 'command not found: jj'

  config="$HOME/.config/jj/generated_config.toml"
  &>/dev/null \
    find -L ~/.jjconfig.toml ~/.config/jj/config.toml ~/.config/jj/extra_configs/ \
    -name '*.toml' -exec python3 ~/.config/jj/scripts/mergeconf.py {} \+ > "$config"
}

main "$@"
