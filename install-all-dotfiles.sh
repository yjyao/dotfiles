#!/usr/bin/env bash

# Run this script
# to install ALL DOTFILE REPOS
# under $DOTFILE_REPO_ROOT_DIR (default: ~/dotfiles) to home.
#
# Each dotfile "repo"
# is a "stow directory"
# that contains a set of "package directories".
# See `man stow` for the relevant definitions.
#
# NOTE:
# Each dotfile repo will be used as a packge itself
# to create the merged repo as well.
# If you have files/folders in the root directory
# of your dotfile repo
# that are NOT meant for stow-ing,
# create a `.stow-local-ignore` file
# at the root directory of your dotfile repo
# to exclude them.
# One common example is a README file
# in your dotfile repo root directory.

set -o errexit  # Exit on first error.

root="${DOTFILE_REPO_ROOT_DIR:-"${HOME}/dotfiles"}"
repos="${root}"
merged_repo="${root}/.merged-repo"

# Clean up: remove existent links and the merged repo.
# This cleans up repos that are removed.
if [[ -d "${merged_repo}" ]]; then
  (cd "${merged_repo}" && stow --target "${HOME}" --delete */)
  rm -rf "${merged_repo}"
fi

mkdir -p "${repos}" "${merged_repo}"

# Merge repos into the merged repo.
(cd "${repos}" && stow --target "${merged_repo}" --restow */)

# Install the packages under the merged repo at home.
(cd "${merged_repo}" && stow --target "${HOME}" --restow */)
