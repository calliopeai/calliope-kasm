#!/usr/bin/env bash
set -ex

# Calliope CLI installation script for Kasm workspaces
# Installs Node.js 24 + @calliopelabs/cli (the exact version in .cli-version) globally
# Supports: linux/amd64, linux/arm64

ARCH=$(dpkg --print-architecture)
echo "Detected architecture: ${ARCH}"

# Map to Node.js release naming
case "${ARCH}" in
    amd64)
        NODE_ARCH="x64"
        ;;
    arm64)
        NODE_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Node 24: Calliope CLI 3.x requires it. On 22, npm silently resolved the newest
# release that still allowed Node 22 (3.2.1), so images never got a newer CLI.
curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt-get install -y nodejs

echo "Node.js $(node --version) installed"
echo "npm $(npm --version) installed"

# The Calliope CLI is ours: pinned to .cli-version and asserted, so a wrong or
# missing CLI fails the build instead of shipping silently.
CLI_VERSION="$(tr -d '[:space:]' < "$(dirname "$0")/cli-version")"
npm install --engine-strict -g "@calliopelabs/cli@${CLI_VERSION}"
calliope --version --json | node -e "const v=JSON.parse(require('node:fs').readFileSync(0,'utf8')).version; if(v!==process.argv[1]) throw new Error('Unexpected Calliope CLI version: '+v); console.log('Calliope CLI '+v+' verified under '+process.version)" "$CLI_VERSION"

# Agent CLIs + SDK backends
# Use || true for packages that may not be published yet
npm install -g \
  @anthropic-ai/claude-code \
  @google/gemini-cli \
  @openai/codex \
  @anthropic-ai/claude-agent-sdk \
  @openai/agents \
  @google/adk \
  || true

echo "Agent CLIs: claude=$(which claude 2>/dev/null || echo 'n/a') gemini=$(which gemini 2>/dev/null || echo 'n/a') codex=$(which codex 2>/dev/null || echo 'n/a')"

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*
