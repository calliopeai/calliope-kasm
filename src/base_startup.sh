#!/usr/bin/env bash
set -ex

# Calliope Base workspace startup script for Kasm
# Opens a terminal with the Calliope CLI ready to use

kasm_startup() {
    # Wait for desktop to be ready
    /usr/bin/desktop_ready

    # Launch terminal
    xfce4-terminal &
}

kasm_startup
