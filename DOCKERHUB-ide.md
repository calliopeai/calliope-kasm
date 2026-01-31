# Calliope AI IDE for Kasm Workspaces

Browser-accessible AI-enhanced development environment powered by [Kasm Workspaces](https://kasmweb.com).

## Quick Start

```bash
docker pull calliopeai/calliope-ide-4kasm:latest
```

### Run Standalone (Testing)

```bash
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password calliopeai/calliope-ide-4kasm:latest
```

Access at `https://localhost:6901` (user: `kasm_user`, password: `password`)

### Deploy to Kasm Workspaces

1. Kasm Admin UI -> Workspaces -> Add Workspace
2. Docker Image: `calliopeai/calliope-ide-4kasm:latest`
3. Recommended settings:
   - Cores: 2+
   - Memory: 4096 MB+
   - Persistent Profile: Optional

## Tags

| Tag | Architecture | Description |
|-----|--------------|-------------|
| `latest` | multi-arch | Latest stable release |
| `X.Y.Z` | multi-arch | Specific version |
| `X.Y.Z-arm64` | linux/arm64 | ARM64 (Apple Silicon, Graviton, etc.) |
| `X.Y.Z-amd64` | linux/amd64 | x86_64 (Intel/AMD) |

## What's Included

- **Calliope AI IDE** - Full-featured AI-enhanced code editor
- **Kasm Desktop** - XFCE4 with KasmVNC
- **Multi-LLM Support** - OpenAI, Anthropic Claude, Google Gemini, Ollama
- **BYOK** - Bring your own API keys, no account required

## Base Image

Built on `kasmweb/core-debian-bookworm:1.17.0` providing:
- Debian 12 (Bookworm)
- XFCE4 desktop environment
- KasmVNC for browser access
- PulseAudio for sound
- GPU support via VirtualGL

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VNC_PW` | VNC/web access password | Required |
| `VNC_RESOLUTION` | Screen resolution | `1920x1080` |

## Resources

- [Calliope AI](https://calliope.ai) - Main website
- [Desktop Releases](https://github.com/calliopeai/calliope-ai-desktop-releases) - Standalone downloads
- [Documentation](https://docs.calliope.ai) - Full docs
- [Discord](https://discord.gg/Z9bbbE6hJv) - Community support

## License

Calliope AI IDE is free to use. See [calliope.ai](https://calliope.ai) for terms.

---

**Built by [Calliope Labs](https://calliope.ai)**
