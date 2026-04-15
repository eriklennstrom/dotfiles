# dotfiles

Personal dotfiles for Arch Linux with Hyprland, using [illogical-impulse](https://github.com/end-4/dots-hyprland) (ii) as the base rice. Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Stack

- **OS:** Arch Linux
- **WM:** Hyprland
- **Shell:** Zsh (oh-my-zsh + Powerlevel10k)
- **Terminal:** Kitty / Ghostty
- **Bar/Widgets:** Quickshell (via illogical-impulse)
- **Editor:** Neovim (LazyVim)
- **Browser:** Chromium

## Setup with Stow

This repo is meant to live at `~/dotfiles`. [GNU Stow](https://www.gnu.org/software/stow/) creates symlinks from your home directory into the repo, so edits in either location stay in sync and under version control.

### Install

```bash
# Clone the repo
git clone git@github.com:eriklennstrom/dotfiles.git ~/dotfiles

# Install stow if needed
sudo pacman -S stow

# Create symlinks (from inside the repo)
cd ~/dotfiles
stow .
```

This symlinks everything into `~`, mirroring the repo structure:

| Repo path | Symlink created |
|---|---|
| `dotfiles/.zshrc` | `~/.zshrc` -> `dotfiles/.zshrc` |
| `dotfiles/.config/hypr/` | `~/.config/hypr` -> `dotfiles/.config/hypr` |
| `dotfiles/.config/nvim/` | `~/.config/nvim` -> `dotfiles/.config/nvim` |
| ... | ... |

### Adding new configs

To start tracking a new config, move it into the repo and re-stow:

```bash
# Example: start tracking starship config
mv ~/.config/starship.toml ~/dotfiles/.config/starship.toml
cd ~/dotfiles
stow .
```

Stow will create the symlink `~/.config/starship.toml` -> `dotfiles/.config/starship.toml`.

### Removing symlinks

```bash
cd ~/dotfiles
stow -D .
```

This removes all symlinks without deleting the actual files in the repo.

### Conflicts

If stow reports a conflict, it means the target file already exists and isn't a symlink. Back it up and re-run:

```bash
mv ~/.config/foo ~/.config/foo.bak
cd ~/dotfiles && stow .
```

## Structure

```
~/dotfiles/
├── .zshrc              # Zsh config
├── .aliases            # Shell aliases
├── .p10k.zsh           # Powerlevel10k prompt
├── .gitconfig          # Git config
└── .config/
    ├── hypr/           # Hyprland config
    │   ├── hyprland/   # Upstream ii defaults (synced on update)
    │   ├── custom/     # Personal overrides (never touched by ii)
    │   ├── monitors.conf
    │   └── workspaces.conf
    ├── quickshell/     # Quickshell/ii widget config
    ├── kitty/          # Kitty terminal config
    ├── ghostty/        # Ghostty terminal config
    ├── nvim/           # Neovim config (LazyVim)
    ├── kanshi/         # Dynamic monitor profiles
    ├── rofi/           # App launcher
    ├── spicetify/      # Spotify theming
    ├── swaync/         # Notification center
    ├── swayosd/        # OSD overlay
    ├── waybar/         # Status bar (legacy, replaced by quickshell)
    └── wallpapers/
```

## illogical-impulse update workflow

The ii repo lives at `~/.cache/dots-hyprland/`. Hyprland overrides are in `hypr/custom/` so upstream files can be synced freely. Quickshell QML customizations and kitty.conf are protected via `~/.config/illogical-impulse/updateignore`.

```bash
cd ~/.cache/dots-hyprland
git stash && git pull
./setup exp-update
```

## Custom hyprland overrides (`hypr/custom/`)

- Swedish keyboard layout (`se`) with caps as ctrl
- Chromium as preferred browser
- Window blur re-enabled (upstream disables it)
- Kitty terminal opacity
- Bar/vertical bar xray disabled for blurred backgrounds
