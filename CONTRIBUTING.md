# Contributing to Calliope AI for Kasm Workspaces

Thanks for your interest in contributing! This guide will help you get started.

## Reporting Issues

- **Bugs**: Use the [bug report template](https://github.com/calliopeai/calliope-kasm/issues/new?template=bug_report.yml)
- **Feature requests**: Use the [feature request template](https://github.com/calliopeai/calliope-kasm/issues/new?template=feature_request.yml)
- **Questions**: Join our [Discord](https://discord.gg/Z9bbbE6hJv)

For issues with the Calliope AI applications themselves (not the Kasm packaging), please file them at [calliope-ai-desktop-releases](https://github.com/calliopeai/calliope-ai-desktop-releases/issues).

## Development Setup

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (with BuildKit enabled)
- [Docker Buildx](https://docs.docker.com/build/buildx/) (for multi-arch builds)
- [Make](https://www.gnu.org/software/make/)

### Build & Test

```bash
# Build for your current platform
make build PRODUCT=ide

# Build a specific product
make build PRODUCT=chat
make build PRODUCT=lab
make build PRODUCT=loadr

# Test locally (builds then runs with VNC on port 6901)
make test PRODUCT=ide
```

Access the running container at `https://localhost:6901` with username `kasm_user` and password `password`.

See the [Makefile](Makefile) for all available targets.

## Pull Requests

1. Fork the repository
2. Create a branch from `main` (`git checkout -b my-change`)
3. Make your changes
4. Test locally with `make test PRODUCT=<affected-product>`
5. Push and open a pull request

### Guidelines

- **One product per PR** when possible - keeps reviews focused
- **Test locally** before submitting - run `make test` for the affected product
- **Keep commits atomic** - each commit should represent a single logical change
- Write clear commit messages: `Fix arm64 detection in install_loadr.sh`

## Project Structure

```
├── Dockerfile.*           # Per-product Dockerfiles
├── src/                   # Installation and startup scripts
│   ├── install_*.sh       # Product installation scripts
│   ├── *_startup.sh       # Product startup scripts
│   └── *.desktop          # Desktop entry files
├── DOCKERHUB-*.md         # Per-product Docker Hub descriptions
├── Makefile               # Build automation
└── .github/workflows/     # CI/CD pipeline
```

## Questions?

Join us on [Discord](https://discord.gg/Z9bbbE6hJv) or open a [discussion](https://github.com/calliopeai/calliope-kasm/issues).
