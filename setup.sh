#!/usr/bin/env bash
# Adds dork40's pacman repo so you can:  sudo pacman -S mural lectern
#   curl -fsSL https://raw.githubusercontent.com/dork40/arch-repo/main/setup.sh | bash
set -euo pipefail
conf=/etc/pacman.conf
if grep -q '^\[dork40\]' "$conf"; then
    echo "The dork40 repo is already in $conf."
else
    printf '\n[dork40]\nSigLevel = Optional TrustAll\nServer = https://github.com/dork40/arch-repo/releases/download/packages\n' \
        | sudo tee -a "$conf" >/dev/null
    echo "Added the dork40 repo to $conf."
fi
sudo pacman -Sy
echo
echo "Done. Now install an app, e.g.:  sudo pacman -S mural    or    sudo pacman -S lectern"
