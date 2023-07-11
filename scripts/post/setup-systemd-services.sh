#!/usr/bin/env bash

set -oue pipefail

echo "Setup systemd units"
systemctl enable getty@tty1
systemctl disable rpm-ostree-countme.service
systemctl enable power-profiles-daemon