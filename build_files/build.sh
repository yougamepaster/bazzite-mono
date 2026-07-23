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
# remake opt as a normal folder because of throne being a bitch
rm -rf /opt
mkdir /opt

# Install Throne, Trivalent, Git, Fastfetch, and Htop
dnf install -y \
    Throne \
    trivalent \
    git \
    fastfetch \
    btop

# set proper perms for thronecore so TUN mode can work
chown root:root /opt/Throne/ThroneCore
chmod u+s /opt/Throne/ThroneCore

echo ">>> Custom build script completed successfully."
