# Dotfiles

My dotfiles. Managed thru [GNU Stow][stow].

NOTE:
This requires you have [GNU Stow][stow] installed.

## Installation

### The Recommended Way

This sets up a specific folder structure
that allows multiple dotfile repos to work together.
One use case is to create a repo for common configs,
and several repos for specific environments
like different OS distributions
or work environments.

To install everything,
you can clone this repo to the *correct location*
and run the installation script
at https://gist.github.com/df68976f158edceb63008d85a12333b1.
You should read the script before running an arbitrary script you found online.
Putting all that together,
here is the command:

```bash
git clone --recursive -j5 https://github.com/yjyao/dotfiles.git ~/dotfiles/yjyao &&
    curl https://gist.githubusercontent.com/raw/df68976f158edceb63008d85a12333b1 | bash
```

You might need to remove (preferably with backups) conflict files.

After this you should have the dotfiles installed.

If you add a new dotfiles repo under `~/dotfiles`,
or added new files to `~/dotfiles/yjyao`,
you can run the install script again to update:

```bash
curl https://gist.githubusercontent.com/raw/df68976f158edceb63008d85a12333b1 | bash
```

To learn about how this works,
read on.

The required folder directory is

```
~/dotfiles/
├── a-repo/
├── another-repo/
├── ...
└── last-repo/
```

where each repo is a "stow directory"
that contains a set of stow "package directories".
Refer to `man stow` for the definitions of these terms.
This Git repository is one of the repos,
so it should be a folder under `~/dotfiles`.

The install script puts all of the repos together
into `~/dotfiles/.merged-repo`,
then stows them to the home directory.

If you would like to install only a subset of the packages from this repo,
here are some options:

-   To exclude a package, for example, `jj`,
    add `yjyao/jj` to `~/.stow-global-ignore`.

-   If you don't want to modify `~/.stow-global-ignore`,
    you can alternatively add to the `.stow-local-ignore` file
    under the root directory of this repo.

-   Clone the repository to a separate location
    and link the desired packages under `~/dotfiles/${reponame?}/`.
    For example,
    to include `jj` in a repo called `default`, run
    ```bash
    ln -s jj ~/dotfiles/default/jj
    ```

If you need to store the dotfile repos
in a directory other than `~/dotfiles`,
you can overwrite `DOTFILE_REPO_ROOT_DIR`
when executing the install script.
For more details,
check the comments at the top
of the [install script](https://gist.github.com/df68976f158edceb63008d85a12333b1).

### The Simple Way

To install everything,

```bash
git clone --recursive -j5 https://github.com/yjyao/dotfiles.git ~/.dotfiles && cd $_ && stow */
```

If you don't need any of the following:

- todo-txt plugins
- vim plugins
- tpm (tmux plugin manager)

then you can skip cloning the submodules and run

```bash
git clone https://github.com/yjyao/dotfiles.git ~/.dotfiles && cd $_ && stow */
```

instead.

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

[stow]: https://www.gnu.org/software/stow/
