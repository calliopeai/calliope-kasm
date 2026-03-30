#!/usr/bin/env bash
set -ex

# Chat Studio installation script for Kasm
# Supports: linux/amd64, linux/arm64

# Detect architecture
ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Chat Studio uses Electron builder arch names (x64, arm64) not Debian names (amd64, arm64)
case "${ARCH}" in
    amd64) RELEASE_ARCH="x64" ;;
    arm64) RELEASE_ARCH="arm64" ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Version to install (can be overridden via build arg)
CALLIOPE_VERSION="${CALLIOPE_VERSION:-1.0.0}"

# Use the GitHub API to find the correct .deb URL for this architecture.
RELEASE_URL="https://api.github.com/repos/calliopeai/calliope-ai-desktop-releases/releases/tags/chat-v${CALLIOPE_VERSION}"

echo "Finding Chat Studio v${CALLIOPE_VERSION} .deb for ${RELEASE_ARCH}..."

DEB_URL=$(wget -qO- "${RELEASE_URL}" \
    | grep -o '"browser_download_url": "[^"]*linux-'"${RELEASE_ARCH}"'[^"]*\.deb"' \
    | head -1 \
    | cut -d'"' -f4)

if [ -z "${DEB_URL}" ]; then
    echo "ERROR: No .deb found for ${RELEASE_ARCH} in chat-v${CALLIOPE_VERSION} release"
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
