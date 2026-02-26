#!/usr/bin/env bash
set -ex

# Loadr startup script for Kasm
# This script runs when a Kasm session starts

ARGS="--no-sandbox"

# Find the binary (check .deb install paths and AppImage extract path)
if command -v loadr-desktop &> /dev/null; then
    START_COMMAND="loadr-desktop"
elif [ -x /usr/bin/loadr-desktop ]; then
    START_COMMAND="/usr/bin/loadr-desktop"
elif [ -x /usr/local/bin/loadr-desktop ]; then
    START_COMMAND="/usr/local/bin/loadr-desktop"
elif [ -x /opt/loadr/loadr-desktop ]; then
    START_COMMAND="/opt/loadr/loadr-desktop"
else
    echo "WARNING: Loadr binary not found"
    exit 0
fi

# Set LD_LIBRARY_PATH for AppImage-extracted installs
if [ -d /opt/loadr ]; then
    export LD_LIBRARY_PATH="/opt/loadr/usr/lib:${LD_LIBRARY_PATH}"
fi

# Startup function
kasm_startup() {
    # Wait for desktop to be ready
    /usr/bin/desktop_ready

    # Launch Loadr
    $START_COMMAND $ARGS &
}

kasm_startup
