#!/usr/bin/env bash
set -ex

# Calliope AI Desktop Suite startup script for Kasm
# All apps are available via desktop shortcuts — just opens a clean desktop

kasm_startup() {
    # Wait for desktop to be ready
    /usr/bin/desktop_ready

    # All apps are launchable from desktop shortcuts and the application menu
    echo "Calliope AI Desktop Suite ready"
}

kasm_startup
