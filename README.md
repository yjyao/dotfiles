# Dotfiles

My dotfiles. Managed thru [GNU Stow][stow].

NOTE:
This requires you have [GNU Stow][stow] installed
For Windows system,
use [Dploy][dploy] in place of GNU Stow.

## Installation

To install everything,

```bash
git clone https://github.com/yjyao/dotfiles.git ~/.dotfiles && cd $_ && stow */
```

The

```bash
stow */
```

command
installs all packages
available in the repository.
Alternatively,
to install a subset of packages of your selection,
go to the dotfiles directory and run

```bash
stow bash vim ... # Add the pacakges your want to install.
```

NOTE:
This requires your dotfiles directory to be
*directly* under home.
If it's not directly under your home,
use `stow -t ~ ...` instead.

[dploy]: https://github.com/arecarn/dploy/
[stow]: https://www.gnu.org/software/stow/
