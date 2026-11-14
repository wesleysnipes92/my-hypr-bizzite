#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ into the image.
cp -avf "/ctx/system_files"/. /

# Hyprland is provided by the Fedora 45 COPR tested on the host.
dnf5 -y copr enable mineiro/hyprland

# Install the desktop alongside the existing GNOME desktop.
dnf5 -y install \
    hyprland \
    waybar \
    kitty \
    rofi \
    Thunar \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    grim \
    slurp \
    wl-clipboard \
    brightnessctl \
    playerctl \
    pavucontrol \
    network-manager-applet \
    lxpolkit \
    papirus-icon-theme \
    google-noto-emoji-fonts \
    tmux

# Do not leave the build-only COPR enabled in the finished image.
dnf5 -y copr disable mineiro/hyprland

# Keep the existing Bazzite/GNOME setup intact; Hyprland is an additional session.
systemctl enable podman.socket
