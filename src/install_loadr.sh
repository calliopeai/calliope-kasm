#!/usr/bin/env bash
set -ex

# Loadr installation script for Kasm
# Supports: linux/amd64 (.deb), linux/arm64 (AppImage fallback)

# Detect architecture
ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Version to install (can be overridden via build arg)
CALLIOPE_VERSION="${CALLIOPE_VERSION:-1.0.2}"

# Loadr uses electron-builder arch names: amd64 → x64, arm64 → arm64
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

# Try .deb first
DEB_URL="https://github.com/calliopeai/calliope-ai-desktop-releases/releases/download/loadr-v${CALLIOPE_VERSION}/loadr-desktop-linux-${RELEASE_ARCH}.deb"

echo "Checking for Loadr v${CALLIOPE_VERSION} .deb for ${RELEASE_ARCH}..."

if wget -q --spider "${DEB_URL}" 2>/dev/null; then
    echo "Downloading .deb: ${DEB_URL}"
    wget -q "${DEB_URL}" -O /tmp/loadr.deb
    apt-get update
    apt-get install -y /tmp/loadr.deb || apt-get install -f -y
    rm /tmp/loadr.deb
else
    # Fall back to AppImage (e.g. arm64 has no .deb yet)
    APPIMAGE_URL="https://github.com/calliopeai/calliope-ai-desktop-releases/releases/download/loadr-v${CALLIOPE_VERSION}/loadr-desktop-linux-${RELEASE_ARCH}.AppImage"

    echo "No .deb available, falling back to AppImage: ${APPIMAGE_URL}"

    if ! wget -q --spider "${APPIMAGE_URL}" 2>/dev/null; then
        echo "ERROR: Neither .deb nor .AppImage available for ${RELEASE_ARCH}"
        exit 1
    fi

    # Install squashfs-tools to extract AppImage without executing it
    # (AppImage --appimage-extract fails under QEMU cross-arch emulation in CI)
    apt-get update
    apt-get install -y squashfs-tools

    wget -q "${APPIMAGE_URL}" -O /tmp/loadr.AppImage

    # Extract AppImage using unsquashfs (skip the ELF header offset)
    # AppImages are squashfs archives with a prepended ELF binary
    OFFSET=$(grep -aobP '\x68\x73\x71\x73' /tmp/loadr.AppImage | head -1 | cut -d: -f1)
    unsquashfs -offset "${OFFSET}" -dest /tmp/squashfs-root /tmp/loadr.AppImage
    mv /tmp/squashfs-root /opt/loadr
    ln -sf /opt/loadr/loadr-desktop /usr/local/bin/loadr-desktop
    rm /tmp/loadr.AppImage

    # Create desktop entry for AppImage install
    cat > /usr/share/applications/loadr-desktop.desktop <<DESKTOP
[Desktop Entry]
Name=Loadr
Exec=loadr-desktop --no-sandbox %F
Icon=loadr-desktop
Type=Application
Categories=Development;
DESKTOP

    # Try to find an icon from the extracted app
    ICON=$(find /opt/loadr -name "*.png" -path "*/icons/*" 2>/dev/null | sort -r | head -1)
    if [ -n "${ICON}" ]; then
        sed -i "s|Icon=loadr-desktop|Icon=${ICON}|" /usr/share/applications/loadr-desktop.desktop
    fi
fi

# Find the installed desktop file and set up shortcut
DESKTOP_FILE=$(find /usr/share/applications -name "*loadr*" -type f 2>/dev/null | head -1)

if [ -n "${DESKTOP_FILE}" ]; then
    cp "${DESKTOP_FILE}" $HOME/Desktop/
    chmod +x $HOME/Desktop/*.desktop
    chown 1000:1000 $HOME/Desktop/*.desktop

    # Ensure --no-sandbox is set (may already be set for AppImage installs)
    grep -q "\-\-no-sandbox" "${DESKTOP_FILE}" || sed -i '/^Exec=/s/$/ --no-sandbox/' "${DESKTOP_FILE}"
    grep -q "\-\-no-sandbox" $HOME/Desktop/*.desktop || sed -i '/^Exec=/s/$/ --no-sandbox/' $HOME/Desktop/*.desktop
fi

echo "Loadr v${CALLIOPE_VERSION} installed successfully"

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
