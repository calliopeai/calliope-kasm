<p align="center">
  <img src="assets/calliope-logo.svg" alt="Calliope AI" width="280">
</p>

<h1 align="center">Calliope AI for Kasm Workspaces</h1>

<p align="center">
  <strong>Browser-accessible AI development environments</strong>
</p>

<p align="center">
  <a href="https://hub.docker.com/r/calliopeai/calliope-ide-4kasm"><img src="https://img.shields.io/docker/v/calliopeai/calliope-ide-4kasm?label=IDE&logo=docker" alt="Docker IDE"></a>
  <a href="https://hub.docker.com/r/calliopeai/calliope-lab-4kasm"><img src="https://img.shields.io/docker/v/calliopeai/calliope-lab-4kasm?label=Lab&logo=docker" alt="Docker Lab"></a>
  <a href="https://github.com/calliopeai/calliope-kasm/actions"><img src="https://img.shields.io/github/actions/workflow/status/calliopeai/calliope-kasm/build-publish.yml?label=build&logo=github" alt="Build Status"></a>
</p>

<p align="center">
  <a href="https://calliope.ai">Website</a> •
  <a href="https://docs.calliope.ai">Documentation</a> •
  <a href="https://discord.gg/Z9bbbE6hJv">Discord</a>
</p>

---

Docker images for running [Calliope AI](https://calliope.ai) desktop applications in [Kasm Workspaces](https://kasmweb.com) - stream a full AI-powered development environment to any browser.

## Products

| Image | Description |
|-------|-------------|
| **calliope-ide-4kasm** | AI-enhanced code editor built on VS Code |
| **calliope-lab-4kasm** | Interactive notebook environment for data analysis |

## Quick Start

### Calliope AI IDE

```bash
# Pull the image
docker pull calliopeai/calliope-ide-4kasm:latest

# Run standalone (for testing)
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password \
  calliopeai/calliope-ide-4kasm:latest
```

### Calliope AI Lab

```bash
# Pull the image
docker pull calliopeai/calliope-lab-4kasm:latest

# Run standalone (for testing)
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password \
  calliopeai/calliope-lab-4kasm:latest
```

**Access:** https://localhost:6901
**Username:** `kasm_user`
**Password:** `password`

## Deploy to Kasm Workspaces

1. **Kasm Admin UI** → Workspaces → Add Workspace
2. **Docker Image:** `calliopeai/calliope-ide-4kasm:latest` (or `calliope-lab-4kasm`)
3. **Recommended Settings:**
   - Cores: 2+
   - Memory: 4096 MB+
   - Persistent Profile: Optional (recommended for Lab)

## Architecture Support

| Architecture | Platform | Status |
|--------------|----------|--------|
| `linux/amd64` | Intel/AMD x86_64 | Supported |
| `linux/arm64` | Apple Silicon, AWS Graviton, Raspberry Pi | Supported |

Images are published as multi-arch manifests - Docker automatically pulls the correct architecture.

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest stable release (multi-arch) |
| `X.Y.Z` | Specific version (multi-arch) |
| `X.Y.Z-amd64` | Specific version, x86_64 only |
| `X.Y.Z-arm64` | Specific version, ARM64 only |

## Base Image

Built on [`kasmweb/core-debian-bookworm:1.17.0`](https://hub.docker.com/r/kasmweb/core-debian-bookworm) providing:

- Debian 12 (Bookworm)
- XFCE4 desktop environment
- KasmVNC for browser streaming
- PulseAudio for audio
- GPU support via VirtualGL

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `VNC_PW` | Access password | Required |
| `VNC_RESOLUTION` | Screen resolution | `1920x1080` |

## Development

```bash
# Build for local testing (IDE)
make build PRODUCT=ide

# Build for local testing (Lab)
make build PRODUCT=lab

# Test locally
make test
```

See the [Makefile](Makefile) for all available commands.

## CI/CD

Images are automatically built and published when new releases are tagged in:
- [calliope-vscode](https://github.com/calliopeai/vscode) → triggers IDE image build
- [lab-desktop](https://github.com/calliopeai/lab-desktop) → triggers Lab image build

## License

Calliope AI applications are free to use. See [calliope.ai](https://calliope.ai) for terms.

---

<p align="center">
  <strong>Built by <a href="https://calliope.ai">Calliope Labs</a></strong>
</p>
