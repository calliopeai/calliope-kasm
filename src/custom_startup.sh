#!/usr/bin/env bash
set -ex

# Calliope AI IDE startup script for Kasm
# This script runs when a Kasm session starts

ARGS="--no-sandbox"

# Find the binary
if command -v calliope-ide &> /dev/null; then
    START_COMMAND="calliope-ide"
elif [ -x /usr/bin/calliope-ide ]; then
    START_COMMAND="/usr/bin/calliope-ide"
elif [ -x /opt/Calliope\ AI\ IDE/calliope-ide ]; then
    START_COMMAND="/opt/Calliope AI IDE/calliope-ide"
else
    echo "WARNING: Calliope IDE binary not found"
    exit 0
fi

# Startup function
kasm_startup() {
    # Wait for desktop to be ready
    /usr/bin/desktop_ready

    # Launch Calliope IDE
    $START_COMMAND $ARGS &
}

kasm_startup
