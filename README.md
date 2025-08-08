# 🌱 lihuax's Dotfiles

> 🧠 Personal configuration files for a Linux development environment.  
> 📍 Primarily used on Arch Linux with Wayland (Hyprland) and Zsh shell.

## 📦 Dependencies

### General

- **Nerd Fonts**
  Patched fonts providing extra glyphs/icons used throughout the terminal UI and status lines.

### Neovim

- **Lua 5.1**
  Required as the runtime for Neovim plugins and custom Lua scripts.
- **Luarocks**
  Lua package manager used to install additional Lua modules.
- **Lua package `luatz`**
  Used for date calculations in the diary and weekly modules, located at:
  `nvim/.config/nvim/lua/lihuax/utils/diary.lua`
- **Yazi**
  Used for yazi.nvim
- **fzf**
  Command-line fuzzy finder for quick file and buffer searching.
- **lazygit**
  Terminal UI for Git, convenient for Git operations inside Neovim.

### Optional (Related to Dashboard / Mail Integration)

- **Neomutt (mail client)**
  Integrated with Neovim dashboard through custom keybindings (see `nvim/.config/nvim/lua/lihuax/plugins/snacks.lua` — dashboard module).
  If you don’t use neomutt or mail features, you can safely remove this part of the configuration.

---

### ⚠️ Notes and Future Plans

- The folders for **notes**, **diary**, and **blog** are referenced in the `snacks` plugin configuration.

## 📁 Directory Structure

```

\~/.dotfiles
├── .stow-local-ignore      # Ignore list for GNU Stow
├── hypr/                   # Hyprland window manager configs
├── hyprpanel/              # Hyprpanel bar configuration
├── kitty/                  # Kitty terminal emulator settings
├── nvim/                   # Neovim configuration
├── pictures/               # Wallpaper
├── scripts/                # Custom scripts or utilities
├── shell/                  # Shell config files (zshrc, bashrc, aliases, etc.)
├── templates/              # User templates
├── tmux/                   # Tmux configuration
└── README.md               # This file

```

> 📝 **Note**: Most configuration files (e.g., `.zshrc`, `.bashrc`, etc.) now reside in the `shell/` directory, following Stow-friendly layout.

---

## 🛠 Usage (with GNU Stow)

This repository is designed to work with [GNU Stow](https://www.gnu.org/software/stow/) for easy symlink management.

To install whole configration:

```bash
chmod +x install.sh
./install.sh
```

To install individual components:

```bash
cd ~/.dotfiles
stow shell
stow tmux
stow nvim
stow hypr
stow hyprpanel
stow kitty
```

---

## 💡 Highlights

- 💻 **Zsh**: Main shell, enhanced with Nerd Font and custom aliases.
- 🧮 **Neovim**: Optimized for programming; plugin manager not included here but `lazy.nvim` is recommended.
- 🧊 **Hyprland**: Wayland-based tiling window manager setup with `hyprpanel` support.
- 🐈 **Kitty**: GPU-based terminal emulator, configured for performance and appearance.
- 📦 **Tmux**: Terminal multiplexer setup with clipboard and truecolor support.
- 🎨 **Nerd Font Support**: Ready for Nerd Font icons and symbols.
- 🧾 **.stow-local-ignore**: Prevents non-dotfiles

---

## 🚧 TODO

- [ ] Currently, these paths and related config in nvim are somewhat scattered; plan to refactor and clean up this part in the near future.
- [ ] Include per-module READMEs (e.g., `nvim/README.md`)
- [ ] Remove any personal or sensitive content
- [ ] Add screenshots of terminal and desktop setup

---

## 📜 License

MIT License.
Feel free to copy, modify, and use.
