#!/bin/sh

# Build the Calliope AI workspace registry
node processing
npm run deploy --prefix site
touch public/.nojekyll
