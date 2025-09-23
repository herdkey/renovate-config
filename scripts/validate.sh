#!/usr/bin/env bash
set -euo pipefail

declare -a files

# Collect all config candidates:
# - Any JSON/JSON5 under renovate/presets
# - renovate.json* at root, .github/, .gitlab/
# - .renovaterc*
while IFS= read -r -d '' f; do
    files+=("$f")
done < <(find renovate/presets . .github .gitlab \
            -type f \
            \( -name 'renovate.json*' -o -name '.renovaterc*' -o -path 'renovate/presets/*.json*' \) \
            -print0 2>/dev/null || true)

if [ "${#files[@]}" -eq 0 ]; then
    echo "No Renovate config files found"
    exit 0
fi

# Show renovate version
echo "==> Renovate version"
npx --yes --package renovate -- renovate -v

for f in "${files[@]}"; do
    echo "==> Validating $f"
    npx --yes --package renovate -- renovate-config-validator "$f"
done
