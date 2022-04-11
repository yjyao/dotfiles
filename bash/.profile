# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

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

# set PATH so it includes golang
if [ -d '/usr/local/go/bin' ] ; then
  PATH="$PATH:/usr/local/go/bin"
fi
if [ -d "$HOME/go/bin" ] ; then
  PATH="$PATH:$HOME/go/bin"
fi

# set PATH for fzf
if [[ -d $HOME/.fzf/bin && "$PATH" != *$HOME/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# import local profile configs
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"
if [ -d "$HOME/.profile.d" ]; then
  for f in "$HOME"/.profile.d/*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi

# import bashrc if available and running bash
[ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
