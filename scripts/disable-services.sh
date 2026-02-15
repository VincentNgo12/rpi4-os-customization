#!/bin/bash
set -e

ROOT=$(dirname "$0")/..
LIST="$ROOT/minimal/disable-services.txt"

echo "[MINIMAL] Disabling services..."

while read svc; do
    [[ "$svc" =~ ^# ]] && continue
    [[ -z "$svc" ]] && continue

    echo "  - Disabling $svc ..."
    sudo systemctl disable "$svc" 2>/dev/null || true
    sudo systemctl stop "$svc" 2>/dev/null || true
done < "$LIST"

echo "[MINIMAL] Done."
