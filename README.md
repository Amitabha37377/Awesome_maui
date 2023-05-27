
# Awesome_maui

Welcome to the Awesome_maui repository! This repository contains the dotfiles used to replicate the maui shell using awesome window manager api. 

![look](/screen-Shot/main.png)
## Table of Contents
- [Dependencies](#Dependencies)
- [Installation (Manual)](#Installation (Manual))
- [Installation using scripts](#installation-using-script) 
- [Features And Widgets](#features-and-widgets)
- [Gallery](#gallery)
- [Defualts](#defaults)
- [Contributing](#contributing)
- [License](#license)

## Dependencies
- **Awesome window manager:** You are probably fine with either the stable release or git version. Configs should work with either of them.
- **Rofi:** The app launcher. For debian based systems you have to build it manualy. For fedora or arch the package available in native repo is fine.
- **Picom:** The compositor. I am using this fork:-https://github.com/pijulius/picom, although any picom fork that supports rounded corners and blur is fine for the setup to work well.
- **Nitrogen:** For changing wallpaper
- **Xinput:** This programme enables touch screen gestures in awesome wm. <i>You can skip installing this if you don't care about touchpad gestures</i>
- **Acpi:** For the battery widget. <i>Again if you can skip this if you are using a desktop and don't care about showing battery percentage</i>
- **Light:** Used for changing brightness. The brightness slider is dependant on this programme.
- **Alsa Utils:** Used for changing volume, the volume slider require this.
- **Scrot & Spectacle:** For taking scrrenshots.
- **Playerctl:** The music player widget is dependant on this programme.
- **Dunst:** For some notifications
- **Lxappearance:** Used for switching themes.
- **Fonts:** The fonts used for this setup are: **JetBrains Nerd Font**, **CaskaydiaCove Nerd Font**, **Inter Font(Optional)**


## Installation (Manual)

1. Clone the repository:
```bash
git clone git@github.com:Amitabha37377/Awesome_maui.git
```
2. Install the dependencies listed above. (The names may vary according to your distro. These are written according to fedora linux)

3. Copy the directories in their required locations:-
```bash
cd Awesome_maui
cp -r .config/awesome $HOME/.config/
cp -r .icons .fonts  $HOME
cp -r .config/rofi $HOME/.config/       #Optional
cp -r .config/kitty $HOME/.config/       #Optional
cp -r .config/nvim $HOME/.config/       #Optional
```
4. Install the necessery fonts.
5. Restart awesome wm.


## Installation using script
#### <i>(Thanks to <a href="https://github.com/rafay99-epic">Abdul Rafay</a>)</i>
To set up this desktop environment, please follow the instructions below.

1. Open the terminal on your Linux system.

2. Clone this project by running the following command:
   ```bash
   git clone https://github.com/Amitabha37377/Awesome_maui
   ```

3. Navigate to the project folder:
   ```bash
   cd Awesome_maui
   ```

4. Installation Steps:
   - Arch Linux:
     - If you are using Arch Linux, run the `arch.sh` script:
       ```bash
       chmod +x arch.sh
       ./arch.sh
      ```
       **Note:** Please ensure that you run this script as a normal user and not as root.
    - Fedora Linux:
      - If you are using Fedora Linux, run the `fedora.sh` script:
       ```bash
        chmod +x fedora.sh
        ./fedora.sh
       ```

   - Other Distributions:
     - For other Linux distributions, please refer to the `pkg` file for specific installation instructions tailored to your distro.

**Note:** It is important to carefully follow the instructions specific to your distribution to ensure a successful setup.

We hope you enjoy using the Awesome_maui desktop environment! Should you encounter any issues or have any questions, please refer to the project documentation or reach out to the community for assistance.

## Features and Widgets
- A toggleable dock where you can add your favorite apps so that you can open them quickly.
- Taglist cum tasklist, so that you can keep track of what programme you opened on which workspace.
- Music Player widget with play/pause, loop, next, previous buttons. <i>Only tested on youtube. Should work for other music players fine though</i>
- Vertical titlebars.
... And many more.

## Gallery
![look](/screen-Shot/blank.png)
![look](/screen-Shot/main.png)
![look](/screen-Shot/rofi.png)
![look](/screen-Shot/terminals.png)

## Defaults
**Superkey:** Windows key
**Terminal:** Kitty
**File Manager:** Thunar
**Text Editor:** Neovim

#### Keybindings
**Super + Enter:** Launches terminal (kitty)
**Super + d:** Launches rofi.
**Super + b:** Hides the dock.
**Super + s:** Opens the list of all shortchut keys.
**Super + shift + q:** Closes the active window.
**Super + <1-9>:** Goes to the respective workspace.
**Super + shift + <1-9>:** Moves the active window to the respective workspace.

## Acknowledgement
- Thanks to <a href="https://github.com/rafay99-epic">Abdul Rafay</a></i> for the installation scripts and other contributions.
- <a href="https://github.com/streetturtle/awesome-wm-widgets">Streetturtle</a> for widgets some of which I used in my config.
- <a href="https://github.com/BlingCorp/bling">Bling</a> for awesome modules I used in the config (Specially the music player widget)
- Awesome wm team for creating and maintaining such an amazing window manager

## Contributing
Contributions to Awesome_maui are welcome and encouraged. If you have improvements, new configurations, or additional resources that you would like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your changes:
   ```shell
   git checkout -b feature/your-feature-name
   ```
3. Make the necessary changes and additions.
4. Commit your changes:
   ```shell
   git commit -am "Add your commit message"
   ```
5. Push the changes to your forked repository:
   ```shell
   git push origin feature/your-feature-name
   ```
6. Open a pull request in this repository, describing the changes you have made and providing any relevant details.

Happy computing!

## License
The content in this repository is licensed under the [MIT License](/LICENSE). You are free to use, modify, and distribute the resources and configurations as per the terms of the license.

## Disclaimer
- Please note that Awesome_maui is provided as-is, without any warranty or guarantee. Use it at your own risk.

- **<i>Disclaimer:</i>**<i>The codebase is really messy, also I am pretty noob in awesomewm api or lua, so handle this files carefully</i>



