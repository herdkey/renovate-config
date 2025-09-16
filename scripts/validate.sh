#!/usr/bin/env bash
set -euo pipefail

# Find all preset files.
files=$(find presets -type f)

if [ -z "$files" ]; then
    echo "No presets found"
    exit 1
fi

# Run validation on each preset file.
for f in $files; do
    echo "==> Validating $f"
    npx --yes --package renovate -- renovate-config-validator "$f"
done
