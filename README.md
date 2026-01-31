# Calliope Kasm Image

Kasm Workspaces image for Calliope AI IDE - browser-accessible AI-enhanced development environment.

## Quick Start

```bash
# Build for local testing
make build

# Test locally (access at https://localhost:6901)
make test
```

## Architecture Support

| Architecture | Status |
|-------------|--------|
| linux/amd64 | Supported |
| linux/arm64 | Supported |

## Building

### Local Development

```bash
# Build for your current platform
make build

# Run locally for testing
make test
# Access: https://localhost:6901
# User: kasm_user
# Pass: password
```

### Multi-Architecture Build

```bash
# Requires docker buildx and registry login
docker login ghcr.io

# Build and push multi-arch image
make build-multi
```

## Base Image

Uses `kasmweb/core-debian-bookworm:1.17.0` (Debian 12) which provides:
- XFCE4 desktop environment
- KasmVNC for remote access
- GPU support via VirtualGL
- PulseAudio for sound

## Files

```
.
├── Dockerfile              # Main image definition
├── Makefile               # Build commands
└── src/
    ├── install_calliope.sh    # Installation script
    ├── custom_startup.sh      # Session startup script
    └── calliope-ide.desktop   # Desktop shortcut
```

## Deployment to Kasm

1. Build and push to your registry
2. In Kasm Admin UI: Workspaces → Add Workspace
3. Configure:
   - Docker Image: `ghcr.io/calliopeai/calliope-ide:latest`
   - Cores: 2+
   - Memory: 4096+ MB
   - GPU: Optional

## Notes

- Electron apps require `--no-sandbox` flag in containers
- Use `1.17.0-rolling-daily` base tag for auto-updates
