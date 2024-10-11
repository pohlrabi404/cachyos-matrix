#!/usr/bin/env bash
# Rebos install
cat | sudo tee -a /etc/pacman.conf << EOF

[oglo-arch-repo]
SigLevel = Optional DatabaseOptional
Server = https://gitlab.com/Oglo12/\$repo/-/raw/main/\$arch

EOF

sudo pacman -Syy
sudo pacman -S rebos --noconfirm

sudo pacman -S git rustup base-devel paru flatpak --noconfirm
sudo pacman -S stow --noconfirm

rebos setup

# Do github clone here

# Change base shell to zsh
chsh -s /usr/bin/zsh

# Install files from repo
sudo pacman -R sway --noconfirm
rebos gen commit "setup commit"
rebos gen current build

# Config sync
rm -rf $HOME/.zshrc $HOME/.bashrc
dir=$(basename $(pwd))
cd ..
stow -v $dir
cd $dir

# Enable keyd for key remap
sudo systemctl enable keyd
sudo systemctl start keyd
cat | sudo tee /etc/keyd/default.conf << EOF
[ids]

*

[main]
shift = oneshot(shift)
muhenkan = oneshot(meta)
control = oneshot(control)

leftalt = oneshot(alt)
capslock = overload(control, esc)
EOF

# Config spotify and spicetify
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

# Set qutebrowser as default
xdg-settings set default-web-browser org.qutebrowser.qutebrowser.desktop
