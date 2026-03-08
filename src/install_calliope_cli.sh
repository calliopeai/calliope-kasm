#!/usr/bin/env bash
set -ex

# Calliope CLI installation script for Kasm workspaces
# Installs Node.js LTS + @calliopelabs/cli globally
# Supports: linux/amd64, linux/arm64

ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Map to Node.js release naming
case "${ARCH}" in
    amd64)
        NODE_ARCH="x64"
        ;;
    arm64)
        NODE_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Install Node.js LTS via NodeSource
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs

echo "Node.js $(node --version) installed"
echo "npm $(npm --version) installed"

# Install Calliope CLI globally
npm install -g @calliopelabs/cli

echo "Calliope CLI installed: $(npx calliope --version 2>/dev/null || echo 'ok')"

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
