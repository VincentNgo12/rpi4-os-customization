#!/bin/bash
set -e

echo "[BOOTSTRAP] Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "[BOOTSTRAP] Installing basic tools..."
sudo apt install -y git vim curl

echo "[BOOTSTRAP] Enabling SPI & I2C modules..."
sudo raspi-config nonint do_i2c 0
sudo raspi-config nonint do_spi 0

echo "[BOOTSTRAP] Done!"
