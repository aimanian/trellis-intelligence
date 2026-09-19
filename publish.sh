#!/usr/bin/env bash
# Publish the Trellis marketing site to https://trellis-intelligence.com
#
#   ./publish.sh "what changed"
#
# Stages tracked changes + new assets, commits, pushes to GitHub Pages, then
# waits until the live site actually serves the new file before reporting.
set -euo pipefail
cd "$(dirname "$0")"

MSG="${1:-}"
if [ -z "$MSG" ]; then
  echo "usage: ./publish.sh \"what changed\"" >&2
  exit 1
fi

# 1. Preview exactly what will go public (never blind-commit a Pages repo).
echo "── changes to publish ──────────────────────────────"
git status --short
echo
read -r -p "Publish these to the live site? [y/N] " ok
[ "$ok" = "y" ] || { echo "aborted."; exit 1; }

# 2. Stage the site, but never the editor's stray copies.
git add index.html CNAME .nojekyll README.md publish.sh 2>/dev/null || true
[ -d assets ] && git add assets/
ls -- *.jpg *.png 2>/dev/null | grep -v '^assets/' | while read -r f; do git add "$f"; done || true

if git diff --cached --quiet; then
  echo "nothing staged — already published."
  exit 0
fi

# 3. Commit and push.
git commit -m "$MSG"
git push origin main

# 4. Wait for GitHub Pages to actually serve it (usually ~20s).
echo -n "waiting for the live site"
LOCAL=$(shasum index.html | cut -d' ' -f1)
for _ in $(seq 1 30); do
  LIVE=$(curl -s https://trellis-intelligence.com/ | shasum | cut -d' ' -f1)
  if [ "$LIVE" = "$LOCAL" ]; then
    echo -e "\n✓ live at https://trellis-intelligence.com"
    exit 0
  fi
  echo -n "."
  sleep 5
done
echo -e "\n! pushed, but the live site has not updated yet — check https://github.com/aimanian/trellis-intelligence/actions"
