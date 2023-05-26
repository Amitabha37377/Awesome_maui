#!/bin/bash

# Banner
echo "

        █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗        ███╗   ███╗ █████╗ ██╗   ██╗██╗
        ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝        ████╗ ████║██╔══██╗██║   ██║██║
        ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗          ██╔████╔██║███████║██║   ██║██║
        ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝          ██║╚██╔╝██║██╔══██║██║   ██║██║
        ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗███████╗██║ ╚═╝ ██║██║  ██║╚██████╔╝██║
        ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝
                                                                                                     
"

# Emojis
rocket="🚀"
motion="🏃"

# Check if running as root
echo "=== ${rocket} Section: Check for root ==="
if [[ $EUID -ne 0 ]]; then
    echo "🚫 This script must be run as root."
    exit 1
fi

# Check internet connectivity
echo "=== ${rocket} Section: Internet Connectivity ==="
ping -c 1 google.com > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "🌐 No internet connection available. Please check your network settings."
    exit 1
fi

echo "=== ${rocket} Section: Check for package manager ==="
# Check package manager (assuming dnf)
if ! command -v dnf &> /dev/null; then
    echo "❌ dnf package manager not found. Exiting."
    exit 1
fi


# Update your System
echo "=== ${rocket} Section: Updating System ==="
sudo dnf update -y

echo "=== ${rocket} Section: Installing RPM Fusion ==="
# sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Free rmfusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# Non Free rmfusion
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Enabling AppStream
sudo dnf group update core -y

# Update your System
echo "=== ${rocket} Section: Updating System ==="
sudo dnf update -y

# Fonts
echo "=== ${rocket} Section: Installing fonts ==="
sudo dnf install -y libreoffice-opensymbol-fonts terminus-fonts google-noto-fonts-common
sudo fc-cache -v

# Installing Packages
pkg=(
    'awesome'
    'network-manager-applet'
    'i3lock'
    'kitty'
    'flatpak'
    'discord'
    'papirus-icon-theme'
)
sudo dnf install -y "${pkg[@]}"

# Enabling Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installing Flatpak apps
sudo flatpak install flathub io.github.shiftey.Desktop -y 
sudo flatpak install flathub com.spotify.Client -y 

# Installing Vs Code 
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -y
sudo dnf install code -y

# Install   Brave Browser
sudo dnf install dnf-plugins-core -y 
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser -y 


# Picom animation
echo "=== ${motion} Section: Animation ==="
git clone https://github.com/jonaburg/picom.git
cd picom
meson --buildtype=release . build
ninja -C build
sudo ninja -C build install
cd ..
rm -rf picom

# Moving Files
echo "=== ${rocket} Section: Moving Files ==="
config_location="$HOME/.config"
cp -R -n .config/*   "$config_location"
cp -R -n .icons  .fonts "$HOME"


echo "✅ Setup complete."

exit 0
