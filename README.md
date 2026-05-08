# My dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Stow creates symlinks from this repo into your home directory, keeping config files version-controlled without moving them out of `~`.

For a good overview of this approach, see [this video](https://www.youtube.com/watch?v=y6XCebnB9gs).

## Requirements

- `git`
- `stow`

## Installation

```bash
git clone git@github.com:cwalcott/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```
