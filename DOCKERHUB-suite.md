# Calliope AI Suite for Kasm Workspaces

Full Calliope AI desktop suite — IDE, notebooks, chat, and data tools in one browser-based workspace, powered by [Kasm Workspaces](https://kasmweb.com).

## Quick Start

```bash
docker pull calliopeai/calliope-desktop-suite-kasm:latest
```

### Run Standalone (Testing)

```bash
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password calliopeai/calliope-desktop-suite-kasm:latest
```

Access at `https://localhost:6901` (user: `kasm_user`, password: `password`)

### Deploy to Kasm Workspaces

1. Kasm Admin UI -> Workspaces -> Add Workspace
2. Docker Image: `calliopeai/calliope-desktop-suite-kasm:latest`
3. Recommended settings:
   - Cores: 4+
   - Memory: 8192 MB+
   - Persistent Profile: Recommended

## Tags

| Tag | Architecture | Description |
|-----|--------------|-------------|
| `latest` | multi-arch | Latest stable release |
| `X.Y.Z` | multi-arch | Specific version |
| `X.Y.Z-arm64` | linux/arm64 | ARM64 (Apple Silicon, Graviton, etc.) |
| `X.Y.Z-amd64` | linux/amd64 | x86_64 (Intel/AMD) |

## What's Included

- **Calliope AI IDE** - Full-featured AI-enhanced code editor
- **Calliope AI Lab** - Interactive notebook environment with AI assistance
- **Chat Studio** - AI-powered data analysis and SQL agent
- **DBLoader** - AI-powered data management studio
- **Calliope CLI** - Multi-model AI agent for development and automation
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

Calliope AI Suite is free to use. See [calliope.ai](https://calliope.ai) for terms.

---

**Built by [Calliope Labs](https://calliope.ai)**

&copy; 2025–2026 Calliope Labs Inc. All rights reserved.
