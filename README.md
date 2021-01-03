# Dotfiles

My dotfiles. Managed thru [GNU Stow][stow].

## Installation

To install everything,

```bash
git clone https://github.com/yjyao/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && ./install
```

Alternatively,
to install a subset of packages of your selection,
go to the dotfiles directory and run

```bash
stow bash vim ... # Add the pacakges your want to install.
```

NOTE:
This requires you have [GNU Stow][1] installed
AND your dotfiles directory is *directly* under home.
If it's not directly under your home,
use `stow -t ~ bash vim ...` instead.

[stow]: https://www.gnu.org/software/stow/
