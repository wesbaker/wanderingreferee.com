#!/bin/bash
set -euo pipefail

# Show draft posts on preview deployments; hide them on production (main).
if [ "${CF_PAGES_BRANCH:-main}" != "main" ]; then
  export PUBLIC_SHOW_DRAFTS=true
fi
npm run build
