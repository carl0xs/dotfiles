# Dotfiles

This repository contains my personal configuration files (dotfiles) to customize and optimize my development environment.

## Included Configurations

- **i3wm**: Layout settings, keyboard shortcuts, and appearance.
- **Kitty**: Theme settings, fonts, and shortcuts.
- **Neovim**: Plugins, mappings, and general settings.
- **Fish**: Aliases, functions, and custom prompt.
- **Tmux**: Keybindings, themes, and CPU plugin.

## Manage Dotfiles with Stow

This repo is organized as Stow packages.

Apply symlinks:

```bash
make copy-dotfiles
```

If you already have real files in `$HOME` (not symlinks), adopt them first:

```bash
make migrate-dotfiles
```

Remove symlinks:

```bash
make unstow-dotfiles
```

Direct Stow usage:

```bash
stow --restow --target="$HOME" --dir="$HOME/.dotfiles" aliases fish git i3 kitty picom polybar tmux
```
