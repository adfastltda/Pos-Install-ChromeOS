#!/bin/bash

# Update and Upgrade system packages
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Add Windsurf repository and install Windsurf
echo "Adding Windsurf repository..."
curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
sudo apt update
sudo apt upgrade windsurf -y

# Install Dependencies
echo "Installing dependencies..."
sudo apt install ffmpeg libsdl2-2.0-0 adb wget gcc git pkg-config meson ninja-build libsdl2-dev libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev libswresample-dev libusb-1.0-0 libusb-1.0-0-dev -y

# Install scrcpy
echo "Installing scrcpy..."
git clone https://github.com/Genymobile/scrcpy
cd scrcpy
./install_release.sh
cd ..

# Configure sysctl.conf for performance
echo "Configuring sysctl.conf for performance..."
sudo tee /etc/sysctl.conf > /dev/null <<EOL
# Reduz o uso de SWAP
vm.swappiness=10
# Melhora a gestão de cache
vm.vfs_cache_pressure=50
EOL
sudo sysctl -p

# Install Flatpak and Flathub
echo "Installing Flatpak and Flathub..."
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Audio/Video Codecs and Libraries
echo "Installing audio/video codecs and libraries..."
sudo apt install faad ffmpeg gstreamer1.0-fdkaac gstreamer1.0-libav gstreamer1.0-vaapi gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly lame libavcodec-extra libavcodec-extra59 libavdevice59 libgstreamer1.0-0 sox twolame vorbis-tools -y

# Install VLC and Kodi
echo "Installing VLC and Kodi..."
sudo apt install vlc kodi -y

# Add and Install Spotify
echo "Adding and installing Spotify..."
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
cd /tmp
wget -qO- https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | gpg --dearmor | sudo dd of=/etc/apt/keyrings/spotify.gpg
cd $HOME
sudo apt update
sudo apt install spotify-client -y

# Install Audacity, GIMP, Handbrake, Inkscape, Kdenlive, OBS Studio, Shotcut
echo "Installing Audacity, GIMP, Handbrake, Inkscape, Kdenlive, OBS Studio, Shotcut..."
sudo apt install audacity gimp handbrake inkscape kdenlive obs-studio shotcut -y

# Install Discord, Telegram, Steam via Flatpak, Bottles
echo "Installing Discord, Telegram, Steam, Bottles via Flatpak..."
flatpak install flathub com.discordapp.Discord -y
sudo apt install telegram-desktop -y  # Installing Telegram using apt as well, as requested.
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.usebottles.bottles -y

# Install Archive Utilities
echo "Installing archive utilities..."
sudo apt install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip -y

echo "Installation complete!"
