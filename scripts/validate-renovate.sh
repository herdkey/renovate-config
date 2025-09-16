#!/usr/bin/env bash
set -euo pipefail

# Find all preset files.
files=$(find presets -type f)

if [ -z "$files" ]; then
    echo "No presets found"
    exit 1
fi

# In CI, we use the official Renovate GitHub action to install renovate.
# Locally, this will fallback to use npx (unless the user has it installed).
if ! command -v renovate &> /dev/null; then
    command="npx --yes --package renovate -- renovate-config-validator"
else
    command="renovate renovate-config-validator"
fi

echo "==> Using $command"

# Run validation on each preset file.
for f in $files; do
    echo "==> Validating $f"
    $command "$f"
done
