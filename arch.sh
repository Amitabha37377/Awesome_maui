#!/bin/bash

# Emojis
rocket="🚀"
success="✅"
warning="⚠️"
error="❌"
package="📦"
install="🔽"
internet="🌐"
files_and_folders="📁"
move="📦"


# Section 1: Checking internet connection
echo "=== ${internet} Section 1: Checking internet connection ==="

ping -c 1 google.com >/dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "${success} Internet connection is available."
else
    echo "${error} Internet connection is not available. Please check your network connection."
    exit 1
fi

# Section 2: Checking package manager
echo "=== ${rocket} Section 2: Checking package manager ==="

if ! command -v pacman &>/dev/null; then
    echo "${error} This script is only compatible with the pacman package manager. Exiting..."
    exit 1
fi

# Section 3: Checking paru installation
echo "=== ${rocket} Section 3: Checking paru installation ==="

if ! command -v paru &>/dev/null; then
    echo "${warning} paru is not installed. Installing paru..."

    # Section 4: Cloning paru repository
    echo "=== ${package} Section 4: Cloning paru repository ==="
    git clone https://aur.archlinux.org/paru.git
    cd paru

    # Section 5: Building and installing paru
    echo "=== ${install} Section 5: Building and installing paru ==="
    makepkg -si

    # Clean up paru repository
    cd ..
    rm -rf paru

    echo "${success} paru has been installed successfully."
else
    echo "${success} paru is already installed."
fi

# Section 6: Installing applications using paru
echo "=== ${package} Section 6: Installing applications using paru ==="

applications=(
    'awesome-git'
    'picom-jonaburg-git'
    'papirus-icon-theme'
    'visual-studio-code-bin'
    'brave'
    'spotify'
    'network-manager-applet-git'
    'i3lock-git'
    'i3lock-color'
    'betterlockscreen'
)

for app in "${applications[@]}"; do
    echo "${install} Installing ${app}..."
    paru -S --noconfirm "$app"
done


# Section 7: Installing applications using pacman
echo "=== ${package} Section 7: Installing applications using pacman ==="

applications=(
    'kitty'
    'lxappearance'
    'nitrogen'
    'variety'
    'fish'
    'zsh'
    'gimp'
    'firefox'
    'nitrogen'

)

for app in "${applications[@]}"; do
    echo "${install} Installing ${app}..."
    sudo pacman -S --noconfirm "$app"
done

echo "${success} All applications have been installed successfully."


# Section 8: Moving files and folders to $HOME/.config
echo "=== ${files_and_folders} Section 8: Moving files and folders to $HOME/.config ==="

source_folder=".config"
destination_folder="$HOME/.config"

# Check if the source folder exists
if [ ! -d "$source_folder" ]; then
    echo "Source folder '$source_folder' not found. Exiting..."
    exit 1
fi

# Check if the destination folder exists, create it if not
if [ ! -d "$destination_folder" ]; then
    mkdir -p "$destination_folder"
fi

# Move all files and folders from source to destination
cp -r "$source_folder"/* "$destination_folder"

if [ $? -eq 0 ]; then
    echo "${move} Files and folders moved to $destination_folder successfully."
else
    echo "Failed to move files and folders to $destination_folder."
fi
