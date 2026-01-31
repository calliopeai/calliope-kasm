#!/usr/bin/env bash
set -ex

# Calliope AI IDE installation script for Kasm
# Supports: linux/amd64, linux/arm64

# Detect architecture
ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Version to install (can be overridden via build arg)
CALLIOPE_VERSION="${CALLIOPE_VERSION:-1.2.9}"

# Map architecture to release naming
case "${ARCH}" in
    amd64)
        RELEASE_ARCH="x64"
        ;;
    arm64)
        RELEASE_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Download URL
DOWNLOAD_URL="https://github.com/calliopeai/calliope-ai-desktop-releases/releases/download/ide-v${CALLIOPE_VERSION}/calliope-ide-linux-${RELEASE_ARCH}.deb"

echo "Downloading Calliope AI IDE v${CALLIOPE_VERSION} for ${RELEASE_ARCH}..."

# Check if the release exists for this architecture
if ! wget -q --spider "${DOWNLOAD_URL}" 2>/dev/null; then
    echo "ERROR: Calliope AI IDE for ${RELEASE_ARCH} not available at ${DOWNLOAD_URL}"
    exit 1
fi

# Download and install .deb package
wget -q "${DOWNLOAD_URL}" -O /tmp/calliope-ide.deb
apt-get update
apt-get install -y /tmp/calliope-ide.deb || apt-get install -f -y
rm /tmp/calliope-ide.deb

# Find the installed desktop file
CALLIOPE_DESKTOP=$(find /usr/share/applications -name "*calliope*" -type f 2>/dev/null | head -1)

if [ -n "${CALLIOPE_DESKTOP}" ]; then
    # Copy desktop file to user desktop
    cp "${CALLIOPE_DESKTOP}" $HOME/Desktop/
    chmod +x $HOME/Desktop/*.desktop
    chown 1000:1000 $HOME/Desktop/*.desktop

    # Modify for container environment (Electron needs --no-sandbox)
    sed -i 's|Exec=\([^ ]*\)|Exec=\1 --no-sandbox|g' "${CALLIOPE_DESKTOP}"
    sed -i 's|Exec=\([^ ]*\)|Exec=\1 --no-sandbox|g' $HOME/Desktop/*.desktop
fi

echo "Calliope AI IDE v${CALLIOPE_VERSION} installed successfully"

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
