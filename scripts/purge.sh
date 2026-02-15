#!/bin/bash
set -e

ROOT=$(dirname "$0")/..
LIST="$ROOT/minimal/purge-packages.txt"

echo "[MINIMAL] Purging packages..."

while read pkg; do
    [[ "$pkg" =~ ^# ]] && continue
    [[ -z "$pkg" ]] && continue

    echo "  - Removing $pkg ..."
    sudo apt-get purge -y "$pkg" 2>/dev/null || true
done < "$LIST"

echo "[MINIMAL] Autoremoving leftover dependencies..."
sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "[MINIMAL] Done."
