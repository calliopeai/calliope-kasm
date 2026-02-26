#!/usr/bin/env bash
set -ex

# Chat Studio startup script for Kasm
# This script runs when a Kasm session starts

ARGS="--no-sandbox"

# Find the binary
if command -v chat-studio &> /dev/null; then
    START_COMMAND="chat-studio"
elif [ -x /usr/bin/chat-studio ]; then
    START_COMMAND="/usr/bin/chat-studio"
elif [ -x "/opt/Chat Studio/chat-studio" ]; then
    START_COMMAND="/opt/Chat Studio/chat-studio"
else
    echo "WARNING: Chat Studio binary not found"
    exit 0
fi

# Startup function
kasm_startup() {
    # Wait for desktop to be ready
    /usr/bin/desktop_ready

    # Launch Chat Studio
    $START_COMMAND $ARGS &
}

kasm_startup
