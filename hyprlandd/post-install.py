#!/usr/bin/env python3

import os
import shutil

home_dir = os.path.expanduser("~") + "/"
config_file_extension = ["conf", "toml", "yaml", "yml"]

def main():
    packages = list()

    # Install paru
    os.system("sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si")
    os.system("cd .. && rm -r paru")

    # Install rust
    os.system("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")

    # Install dotfiles
    os.system("git clone https://github.com/pindjouf/dotfiles.git && cd dotfiles/hyprlandd")

    with open("../package_list.txt", "r") as file:
        for line in file:
            line = line.strip("\n")
            if line and "#" not in line:
                package = line
                packages.append(package)

    packages = ' '.join(packages)
    os.system(f'paru -S {packages}')

    # Install starship
    os.system("curl -sS https://starship.rs/install.sh | sh")

    # Configure dotfiles
    os.mkdir(f"{home_dir}.config/")

    with os.scandir('.') as it:
        for entry in it:
            if entry.is_dir():
                shutil.move(entry.name, f"{home_dir}.config/")
            if entry.is_file() and entry.name[entry.name.index(".")+1:] in config_file_extension:
                shutil.move(entry.name, f"{home_dir}.config/")

    shutil.move("../zsh", f"{home_dir}.zsh")
    shutil.move("../.zshrc", f"{home_dir}.zshrc")

    os.system("cd ~ && rm -r dotfiles")

if __name__ == "__main__":
    main()
