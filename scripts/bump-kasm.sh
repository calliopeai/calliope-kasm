#!/usr/bin/env bash
# Bump the supported Kasm Workspaces version across all touchpoints.
#
# Usage: ./scripts/bump-kasm.sh <new-version>   e.g. ./scripts/bump-kasm.sh 1.20.0
#
# Updates:
#   1. Makefile                              KASM_VERSION pin
#   2. Dockerfile.base                       ARG KASM_VERSION default
#   3. .github/workflows/build-publish.yml   KASM_VERSION env
#   4. processing/add_next_version.js        baseversion
#   5. workspaces/*/workspace.json           compatibility list (rolling window of 2)
#   6. README.md / DOCKERHUB-*.md            kasmweb/core-debian-bookworm:X.Y.Z reference
#
# Idempotent. Run on each branch (main, 1.1) you want to bump.

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <new-kasm-version>   e.g. $0 1.20.0" >&2
  exit 1
fi

NEW="$1"
if ! [[ "$NEW" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must be X.Y.Z (got: $NEW)" >&2
  exit 1
fi

MAJOR_MINOR="${NEW%.*}"   # 1.20.0 -> 1.20
NEW_COMPAT="${MAJOR_MINOR}.x"

cd "$(dirname "$0")/.."

# Build pins (1-3)
sed -i.bak -E "s/^KASM_VERSION := .*/KASM_VERSION := ${NEW}/" Makefile
sed -i.bak -E "s/^ARG KASM_VERSION=\".*\"/ARG KASM_VERSION=\"${NEW}\"/" Dockerfile.base
sed -i.bak -E "s/^  KASM_VERSION: '.*'/  KASM_VERSION: '${NEW}'/" .github/workflows/build-publish.yml

# Processing script baseversion (4)
sed -i.bak -E "s/^const baseversion = '.*'/const baseversion = '${MAJOR_MINOR}'/" processing/add_next_version.js

# Workspace compatibility lists (5) — append new, keep last 2
for f in workspaces/*/workspace.json; do
  NEW_COMPAT="$NEW_COMPAT" NEW_FULL="$NEW" FILE="$f" node -e '
    const fs = require("fs");
    const path = process.env.FILE;
    const newVer = process.env.NEW_COMPAT;
    const newFull = process.env.NEW_FULL;
    const p = JSON.parse(fs.readFileSync(path));
    const exists = p.compatibility.some(c => c.version === newVer);
    if (!exists) {
      const last = p.compatibility[p.compatibility.length - 1];
      const image = last.image.split(":")[0];
      p.compatibility.push({
        version: newVer,
        image: image + ":develop",
        uncompressed_size_mb: 0,
        available_tags: ["develop", newFull, newFull + "-rolling-weekly", newFull + "-rolling-daily"]
      });
    }
    if (p.compatibility.length > 2) p.compatibility = p.compatibility.slice(-2);
    fs.writeFileSync(path, JSON.stringify(p, null, 2) + "\n");
  '
done

# Markdown docs (6) — README + DOCKERHUB-*.md base image refs
for f in README.md DOCKERHUB-*.md; do
  [ -f "$f" ] || continue
  sed -i.bak -E "s|kasmweb/core-debian-bookworm:[0-9]+\.[0-9]+\.[0-9]+|kasmweb/core-debian-bookworm:${NEW}|g" "$f"
done

find . -name "*.bak" -type f -delete

echo "Bumped Kasm version to ${NEW}. Review:"
git diff --stat
