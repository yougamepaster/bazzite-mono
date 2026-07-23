#!/usr/bin/bash

set -eou pipefail

echo ">>> Setting up custom RPM repositories..."

# 1. Add your Throne GitHub Pages RPM repository
cat <<'EOF' > /etc/yum.repos.d/throne-custom.repo
[throne-rpm]
name=Throne RPM
baseurl=https://yougamepaster.github.io/throne-rpm/
enabled=1
gpgcheck=0
EOF

# 2. Add secureblue repo for Trivalent
curl -sL -o /etc/yum.repos.d/secureblue.repo https://repo.secureblue.dev/secureblue.repo

echo ">>> Installing native RPM packages..."
# Install Throne, Trivalent, Git, Fastfetch, and Htop
dnf install -y \
    Throne \
    trivalent \
    git \
    fastfetch \
    htop

# Clean up build repo file so it doesn't linger in final OS deployment
rm -f /etc/yum.repos.d/throne-custom.repo

echo ">>> Installing Flatpak packages..."
# Ensure Flathub is enabled and install Discord at system scope
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y --system flathub com.discordapp.Discord

echo ">>> Custom build script completed successfully."
