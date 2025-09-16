# Use bash and fail immediately on errors
set shell := ["/usr/bin/env", "bash", "-euo", "pipefail", "-c"]

validate:
    "{{justfile_directory()}}/scripts/validate.sh"
