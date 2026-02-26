#!/usr/bin/env bash
set -ex

# Chat Studio installation script for Kasm
# Supports: linux/amd64, linux/arm64

# Detect architecture (Chat Studio uses standard Debian arch names in .deb filenames)
ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Version to install (can be overridden via build arg)
CALLIOPE_VERSION="${CALLIOPE_VERSION:-1.0.0}"

# Chat Studio .deb filenames include a build version that may differ from the release tag.
# Use the GitHub API to find the correct .deb URL for this architecture.
RELEASE_URL="https://api.github.com/repos/calliopeai/calliope-ai-desktop-releases/releases/tags/chat-v${CALLIOPE_VERSION}"

echo "Finding Chat Studio v${CALLIOPE_VERSION} .deb for ${ARCH}..."

DEB_URL=$(wget -qO- "${RELEASE_URL}" \
    | grep -o '"browser_download_url": "[^"]*linux-'"${ARCH}"'[^"]*\.deb"' \
    | head -1 \
    | cut -d'"' -f4)

if [ -z "${DEB_URL}" ]; then
    echo "ERROR: No .deb found for ${ARCH} in chat-v${CALLIOPE_VERSION} release"
    echo "Release URL: ${RELEASE_URL}"
    exit 1
fi

echo "Downloading: ${DEB_URL}"

# Download and install .deb package
wget -q "${DEB_URL}" -O /tmp/chat-studio.deb
apt-get update
apt-get install -y /tmp/chat-studio.deb || apt-get install -f -y
rm /tmp/chat-studio.deb

# Find the installed desktop file
DESKTOP_FILE=$(find /usr/share/applications -name "*chat*" -o -name "*Chat*" -type f 2>/dev/null | head -1)

if [ -n "${DESKTOP_FILE}" ]; then
    # Copy desktop file to user desktop
    cp "${DESKTOP_FILE}" $HOME/Desktop/
    chmod +x $HOME/Desktop/*.desktop
    chown 1000:1000 $HOME/Desktop/*.desktop

    # Modify for container environment (Electron needs --no-sandbox)
    sed -i '/^Exec=/s/$/ --no-sandbox/' "${DESKTOP_FILE}"
    sed -i '/^Exec=/s/$/ --no-sandbox/' $HOME/Desktop/*.desktop
fi

echo "Chat Studio v${CALLIOPE_VERSION} installed successfully"

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
