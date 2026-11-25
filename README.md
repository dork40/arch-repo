# dork40's Arch repo

Pacman packages for my apps:

- **[mural](https://github.com/dork40/mural)**: live wallpapers (shaders, videos, pictures)
- **[lectern](https://github.com/dork40/lectern)**: audiobook player

## Set up (once)

```sh
curl -fsSL https://raw.githubusercontent.com/dork40/arch-repo/main/setup.sh | bash
```

Or add this to `/etc/pacman.conf` yourself, then run `sudo pacman -Sy`:

```ini
[dork40]
SigLevel = Optional TrustAll
Server = https://github.com/dork40/arch-repo/releases/download/packages
```

## Install

```sh
sudo pacman -S mural
sudo pacman -S lectern
```

Updates arrive with your normal `sudo pacman -Syu`.

The packages are built from the tagged source of each app, and the PKGBUILDs live in those
repos. They aren't GPG-signed yet; they're downloaded over HTTPS from GitHub.
