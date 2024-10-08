# 🔧 pindjouf's Dotfiles

Welcome to my dotfiles! These configurations power my setups for various window managers including **bspwm**, **Hyprland**, and **qtile**. If you're looking to explore or customize your own Linux environment, feel free to dive in and adapt these to your needs.

## 🖥️ Window Manager Setups

### 1. **Hyprland**

![hyprland screenshot](/assets/hyprland.png)

### 2. **bspwm** -> ~~stolen~~/forked from [gh0stzk](https://github.com/gh0stzk/dotfiles)

![bspwm screenshot](/assets/bspwm.gif)

### 3. **qtile**

![qtile screenshot](/assets/qtile.png)

## 🛠️ What's Inside

- **Neovim**
- **Alacritty**/**Kitty** as the terminal of choice.
- **Gruvbox** theme applied across most environments for a consistent look and feel.
- Custom **zsh** configurations to make terminal workflows efficient.
- Scripts to handle system utilities, shortcuts, and custom workflows.

## 🌐 Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/pindjouf/dotfiles.git ~/dotfiles
   ```

2. Copy the relevant configs to their respective locations:
   ```bash
   cp -r ~/dotfiles/.config/* ~/.config/
   ```

3. (Optional) Install dependencies for each environment listed below.

## 📦 Dependencies

- **bspwm**: bspwm, sxhkd, polybar
- **Hyprland**: hyprland, waybar, wlroots
- **qtile**: qtile, rofi, picom
- **Terminal**: alacritty, zsh, oh-my-zsh
- **Text Editor**: neovim (with plugins)

If there's something missing just figure it out bro I'm sorry.
