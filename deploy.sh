#!/usr/bin/env bash
# Deploys index.html to GitHub Pages as a standalone site.
#
# Usage:
#   ./deploy.sh <github-username> <repo-name>
#
# Result: https://<github-username>.github.io/<repo-name>/

set -euo pipefail

GH_USER="${1:?Usage: ./deploy.sh <github-username> <repo-name>}"
REPO_NAME="${2:?Usage: ./deploy.sh <github-username> <repo-name>}"

cd "$(dirname "$0")"

if [ ! -f index.html ]; then
  echo "index.html not found in $(pwd)"
  exit 1
fi

git init -q 2>/dev/null || true
git add index.html README.md deploy.sh
git commit -q -m "Stone fraction tool" || true
git branch -M main

if command -v gh >/dev/null 2>&1; then
  if git remote get-url origin >/dev/null 2>&1; then
    git push -u origin main
  else
    gh repo create "${GH_USER}/${REPO_NAME}" --public --source=. --remote=origin --push
  fi
  gh api "repos/${GH_USER}/${REPO_NAME}/pages" -X POST -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
    || echo "Note: Pages already enabled, or enable manually under Settings > Pages (main, / root)."
else
  echo "GitHub CLI (gh) not found."
  echo "1) Create an empty repo at https://github.com/new named '${REPO_NAME}'"
  echo "2) git remote add origin https://github.com/${GH_USER}/${REPO_NAME}.git && git push -u origin main"
  echo "3) Settings > Pages, source 'main' branch, '/' root."
  exit 0
fi

echo ""
echo "Live in a minute at: https://${GH_USER}.github.io/${REPO_NAME}/"
