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
  <a href="https://hub.docker.com/r/calliopeai/calliope-chat-studio-kasm"><img src="https://img.shields.io/docker/v/calliopeai/calliope-chat-studio-kasm?label=Chat%20Studio&logo=docker" alt="Docker Chat Studio"></a>
  <a href="https://hub.docker.com/r/calliopeai/calliope-loadr-kasm"><img src="https://img.shields.io/docker/v/calliopeai/calliope-loadr-kasm?label=Loadr&logo=docker" alt="Docker Loadr"></a>
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
| **calliope-chat-studio-kasm** | AI-powered SQL agent for natural language database queries |
| **calliope-loadr-kasm** | AI-powered data management studio with multi-database support |

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
docker pull calliopeai/calliope-lab-4kasm:latest
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password \
  calliopeai/calliope-lab-4kasm:latest
```

### Chat Studio

```bash
docker pull calliopeai/calliope-chat-studio-kasm:latest
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password \
  calliopeai/calliope-chat-studio-kasm:latest
```

### Loadr

```bash
docker pull calliopeai/calliope-loadr-kasm:latest
docker run --rm -it --shm-size=512m -p 6901:6901 -e VNC_PW=password \
  calliopeai/calliope-loadr-kasm:latest
```

**Access:** https://localhost:6901
**Username:** `kasm_user`
**Password:** `password`

## Deploy to Kasm Workspaces

1. **Kasm Admin UI** → Workspaces → Add Workspace
2. **Docker Image:** `calliopeai/calliope-ide-4kasm:latest` (or `lab-4kasm`, `chat-studio-kasm`, `loadr-kasm`)
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

## Connecting to Ollama

Calliope AI apps support [Ollama](https://ollama.com) for local LLM inference. Since Kasm containers run in an isolated Docker network, you need to make Ollama accessible from inside the container.

### Standalone Docker (testing)

Use `--add-host` to map `host.docker.internal` to your host machine:

```bash
docker run --rm -it --shm-size=512m -p 6901:6901 \
  -e VNC_PW=password \
  --add-host=host.docker.internal:host-gateway \
  calliopeai/calliope-chat-studio-kasm:latest
```

Then configure the Ollama URL inside the app as `http://host.docker.internal:11434`.

### Kasm Workspaces deployment

In the Kasm Admin UI, add a **Docker Run Config Override** to the workspace:

```json
{"hostname":"kasm","add_host":["host.docker.internal:host-gateway"]}
```

Alternatively, if Ollama runs on a separate server, use the server's IP/hostname directly (e.g. `http://ollama.internal:11434`).

### Ollama network binding

By default, Ollama only listens on `127.0.0.1`. To allow connections from Docker containers, set:

```bash
OLLAMA_HOST=0.0.0.0 ollama serve
```

Or in your Ollama systemd service file, add `Environment="OLLAMA_HOST=0.0.0.0"`.

### Supported models

Available models are auto-detected from your Ollama instance. Tested with:

- **DeepSeek R1** — reasoning and code generation
- **Qwen3** — general purpose
- **Qwen3-Coder** — code-focused tasks
- **LLaVA** — vision/multimodal (some features)

Other models may work but are not guaranteed. If you run into issues with a specific model, [file a GitHub issue](https://github.com/calliopeai/calliope-ai-desktop-releases/issues) and we'll try to accommodate.

## Development

```bash
# Build for local testing
make build PRODUCT=ide          # Calliope AI IDE
make build PRODUCT=lab          # Calliope AI Lab
make build PRODUCT=chat         # Chat Studio
make build PRODUCT=loadr        # Loadr

# Test locally
make test PRODUCT=chat
```

See the [Makefile](Makefile) for all available commands.

## CI/CD

Images are automatically built and published on tag push or repository dispatch:

| Tag Pattern | Product | Image |
|------------|---------|-------|
| `ide-v*` | Calliope AI IDE | `calliope-ide-4kasm` |
| `lab-v*` | Calliope AI Lab | `calliope-lab-4kasm` |
| `chat-v*` | Chat Studio | `calliope-chat-studio-kasm` |
| `loadr-v*` | Loadr | `calliope-loadr-kasm` |

## License

Calliope AI applications are free to use. See [calliope.ai](https://calliope.ai) for terms.

---

<p align="center">
  <strong>Built by <a href="https://calliope.ai">Calliope Labs</a></strong>
</p>
