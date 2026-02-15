#!/bin/bash
set -e

echo "[INSTALL] Installing packages from packages/package-list.txt..."

while read pkg; do
    [[ -z "$pkg" ]] && continue
    echo "Installing: $pkg"
    sudo apt install -y "$pkg"
done < "$(dirname "$0")/../packages/package-list.txt"

echo "[INSTALL] Finished package installation."
