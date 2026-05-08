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

## Branches

This repo has two long-lived branches that must be kept in sync:

- **`1.1`** is the **default branch** and the source of truth for production deploys. The Kasm Workspaces registry that customers add (built by `.github/workflows/registry-deploy.yml`) is generated from `1.1`. **All fixes intended for production must land on `1.1`.**
- **`main`** mirrors `1.1` and is kept identical via merge or parallel commits. It exists for legacy/tooling reasons; do not commit there exclusively.

If you commit only to `main`, your change will not ship — Kasm pulls workspaces from the registry built from `1.1`, and tag-triggered CI also evaluates relative to the default branch. When in doubt:

```bash
git rev-parse --abbrev-ref HEAD               # confirm you're on 1.1
gh api repos/calliopeai/calliope-kasm --jq .default_branch  # confirms default is 1.1
```

To keep both branches in sync after work on `1.1`:

```bash
git checkout main && git merge --ff-only 1.1 && git push origin main
```

## Pull Requests

1. Fork the repository
2. Create a branch from `1.1` (`git checkout 1.1 && git checkout -b my-change`)
3. Make your changes
4. Test locally with `make test PRODUCT=<affected-product>`
5. Push and open a pull request **targeting `1.1`**

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
