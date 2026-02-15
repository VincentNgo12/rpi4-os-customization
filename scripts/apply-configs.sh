#!/bin/bash
set -e

ROOT=$(dirname "$0")/..

echo "[CONFIG] Updating config.txt safely..."

# Remove old custom block
sudo sed -i '/# --- CUSTOM SETTINGS BELOW ---/,$d' /boot/firmware/config.txt

# Append new custom block
cat "$ROOT/overlays/config.txt" | sudo tee -a /boot/firmware/config.txt > /dev/null
echo "[CONFIG] config.txt patched."

echo "[CONFIG] Copying DT overlays..."
sudo mkdir -p /boot/firmware/overlays
sudo cp "$ROOT/overlays/dt-overlays/"*.dtbo /boot/firmware/overlays/ 2>/dev/null || true

echo "[CONFIG] Installing kernel module list..."
sudo cp "$ROOT/kernel/modules.txt" /etc/modules-load.d/custom-modules.conf

echo "[CONFIG] Applying systemd service files..."
sudo cp $ROOT/systemd/services/* /etc/systemd/system/ 2>/dev/null || true
sudo systemctl daemon-reload

echo "[CONFIG] Enabling systemd services..."
for svc in $ROOT/systemd/enable/*; do
    sudo systemctl enable "$(basename "$svc")"
done

echo "[CONFIG] Disabling systemd services..."
for svc in $ROOT/systemd/disable/*; do
    sudo systemctl disable "$(basename "$svc")"
done

echo "[CONFIG] Done!"
