# dotfiles

Personal dotfiles for Arch Linux with Hyprland, using [illogical-impulse](https://github.com/end-4/dots-hyprland) (ii) as the base rice.

## Stack

- **OS:** Arch Linux
- **WM:** Hyprland
- **Shell:** Zsh (oh-my-zsh + Powerlevel10k)
- **Terminal:** Kitty / Ghostty
- **Bar/Widgets:** Quickshell (via illogical-impulse)
- **Editor:** Neovim (LazyVim)
- **Browser:** Chromium

## Structure

```
.config/
├── hypr/           # Hyprland config (symlinked to ~/.config/hypr)
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
