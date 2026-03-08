#!/bin/sh

# Build the Calliope AI workspace registry

# 1. Process workspaces into list.json + icons (outputs to public/)
node processing

# 2. Preserve processing output before site build overwrites public/
cp -a public/. /tmp/registry-data/

# 3. Build the Next.js site (outputs to public/, wiping previous contents)
npm run deploy --prefix site

# 4. Restore processing output into the built site
cp -a /tmp/registry-data/. public/

touch public/.nojekyll
