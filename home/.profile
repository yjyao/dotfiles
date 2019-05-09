# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

if [ -d "$HOME/utility-scripts" ]; then
  PATH="$HOME/utility-scripts:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin.local" ] ; then
  PATH="$HOME/bin.local:$PATH"
fi

# import local profile configs
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"

# import bashrc if available and running bash
[ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
