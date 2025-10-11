# 🧠 Rahul’s macOS Productivity & Developer Environment

> **A clean, minimal, and automation-ready macOS setup for engineering management, note-taking, and focused work.**

This repository contains my personal **dotfiles** — a complete macOS setup designed for:

- ⚙️ Productivity and focus  
- 🧭 Seamless terminal experience  
- 🪶 Personal knowledge management (notes, wiki, journaling)  
- 🧰 Lightweight coding, debugging, and reviews

It’s built using **Neovim**, **Tmux**, **Alacritty**, **Zsh**, and **Homebrew**, along with **SKHD** and **Yabai** for macOS automation.

---

## 🚀 Quick Start

### 1️⃣ Clone the repository
```bash
git clone git@github.com:guptar85/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

---

### 2️⃣ Run the setup script

This script will:
- Install **Homebrew** (if not installed)
- Install all **brew packages** listed in the `Brewfile`
- Create **symbolic links** for configuration files
- Install **Node.js (LTS)** using **NVM**

```bash
bash setup/dotsetup.sh
```

---

### 3️⃣ Post-install setup

Run this after installation to finalize the environment:

```bash
bash setup/postinstall.sh
```

This will:
- Reload your shell environment
- Verify fonts, themes, and Neovim setup
- Ensure all terminal tools are properly linked

---

## 🧩 Environment Components

| Tool | Purpose | Config Path |
|------|----------|-------------|
| 🧠 **Neovim** | Notes, markdown, and lightweight dev | `~/.config/nvim` |
| 🪟 **Tmux** | Session and window management | `~/.config/tmux` |
| ⚡ **SKHD** | macOS keyboard shortcuts | `~/.config/skhd` |
| 🧱 **Yabai** | Window management | `~/.config/yabai` |
| 🪶 **Alacritty** | Terminal emulator | `~/.config/alacritty` |
| 🐚 **Zsh** | Shell + aliases + plugins | `~/.zshrc`, `.zprofile` |

---

## 📦 Installed Homebrew Packages

These are the main command-line tools used in this setup:

```
bat
colima
docker
eza
fd
fzf
git-delta
go
koekeishiya/formulae/skhd
koekeishiya/formulae/yabai
lazygit
lf
mpv
mupdf
neovim
powerlevel10k
ripgrep
terminal-notifier
tmux
trash-cli
zoxide
zsh-autosuggestions
zsh-syntax-highlighting
```

> You can view and modify these inside [`setup/Brewfile`](setup/Brewfile).

---

## 🔗 Symlink Management

All configs are linked from this repo into `~/.config` using:

```bash
bash setup/symlinks.sh
```

Supported modes:
| Mode | Description |
|------|--------------|
| `dry-run` | Preview all actions without changes |
| `normal` | Create/update symlinks (with backup) |
| `no-action` | Skip linking safely |

Backups of existing files are created automatically as `<file>.bak`.

---

## 🌐 Included Scripts

| Script | Location | Purpose |
|--------|-----------|----------|
| `dotsetup.sh` | `setup/` | Complete bootstrap (brew, nvm, symlinks) |
| `postinstall.sh` | `setup/` | Final steps after setup |
| `symlinks.sh` | `setup/` | Safe symlink creation |
| `raindrop.sh` | `scripts/` | Adds bookmark to [Raindrop.io](https://raindrop.io) |
| `notes.sh` | `scripts/` | Launch Neovim notes dashboard or create new note |

---

## 🧠 Neovim Setup

A modular Neovim configuration tailored for **note-taking**, **documentation**, and **light development**.

### Core Plugins:
- 🗒️ [Telekasten.nvim](https://github.com/renerocksai/telekasten.nvim) — Note-taking & PKM  
- 🔍 [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) — Fuzzy finding  
- ✨ [LuaSnip](https://github.com/L3MON4D3/LuaSnip) — Snippet management  
- 🎨 [Catppuccin](https://github.com/catppuccin/nvim) / [Gruvbox](https://github.com/morhetz/gruvbox) — Themes  
- 🧠 [Trouble.nvim](https://github.com/folke/trouble.nvim) — Diagnostics viewer  
- 🪶 [Render Markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) — Markdown preview  

---

## 🪶 Useful Shortcuts

| Action | Shortcut | Description |
|--------|-----------|-------------|
| 🗒️ Notes Dashboard | `Hyper + N` | Opens Telekasten panel |
| 🔖 Bookmark URL | `Hyper + B` | Adds clipboard URL to Raindrop.io |
| 🪟 Switch tmux window | `⌥ + Tab` | Switch between tmux windows |
| 🔍 File search | `<leader> f f` | Telescope file finder |
| 🧠 Daily note | `<leader> z d` | Open today’s note |
| 📘 Wiki panel | `<leader> z p` | Telekasten command panel |
| 🪶 Markdown preview | `<leader> z v` | Browser preview |

---

## 🔒 API Token Security

Sensitive tokens (like your Raindrop.io key) are **stored securely** in macOS Keychain — not hardcoded.

To add your Raindrop token:
```bash
security add-generic-password -a "$USER" -s "raindrop_token" -w "<YOUR_API_KEY>"
```

Your scripts will automatically retrieve it when needed.

---

## 💾 Backup & Portability

All scripts are **idempotent** — re-running them won’t break your setup.  
Existing configs are backed up automatically:

```
~/.config/nvim.bak/
~/.zshrc.bak
```

To set up on a new Mac:
```bash
git clone git@github.com:guptar85/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup/dotsetup.sh
```

You’ll get an identical environment in minutes 🚀

---

## 🧰 Folder Structure

```
~/.dotfiles
├── config/          # App configurations (Neovim, Tmux, Yabai, etc.)
│   ├── nvim/
│   ├── tmux/
│   ├── alacritty/
│   ├── yabai/
│   └── skhd/
│
├── scripts/         # Utility scripts (Raindrop, Notes, etc.)
├── setup/           # Automated setup and symlink scripts
├── zshrc.d/         # Modular zsh configurations
└── README.md
```

---

## 🧩 Optional Enhancements

For future improvements, consider adding:

- [Starship Prompt](https://starship.rs) — cross-shell prompt  
- [Atuin](https://github.com/ellie/atuin) — synced shell history  
- [Zellij](https://zellij.dev) — tmux alternative  
- [Glow](https://github.com/charmbracelet/glow) — terminal Markdown preview  

---

## 🧑‍💻 About

**Rahul Gupta**  
> Engineering Manager · Productivity Enthusiast · macOS Power User  

A carefully crafted environment for focused work, note-taking, and hands-on leadership.  
The goal: **Stay keyboard-driven, distraction-free, and portable.**

---

## 🧡 Credits

Thanks to the open-source community ❤️

- [Neovim](https://neovim.io/)
- [Alacritty](https://github.com/alacritty/alacritty)
- [Tmux](https://github.com/tmux/tmux)
- [Yabai](https://github.com/koekeishiya/yabai)
- [SKHD](https://github.com/koekeishiya/skhd)
- [Telekasten.nvim](https://github.com/renerocksai/telekasten.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

---

## 🧭 TL;DR

```bash
git clone git@github.com:guptar85/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash setup/dotsetup.sh
bash setup/postinstall.sh
```

✨ You now have a clean, fast, and distraction-free macOS environment for productivity and development.
