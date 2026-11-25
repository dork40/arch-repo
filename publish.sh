#!/usr/bin/env bash
# publish.sh <package.pkg.tar.zst>...: add/update packages in the repo and upload everything.
# Old versions of a package are dropped from the release automatically.
set -euo pipefail
cd "$(dirname "$0")/pkgs"
for p in "$@"; do cp "$p" .; done
repo-add -q -R dork40.db.tar.gz ./*.pkg.tar.zst
rm -f dork40.db dork40.files
cp dork40.db.tar.gz dork40.db
cp dork40.files.tar.gz dork40.files
# keep only the files the database points to
keep=$(tar -xzOf dork40.db.tar.gz --wildcards '*/desc' | awk '/%FILENAME%/{getline; print}')
for f in ./*.pkg.tar.zst; do grep -qx "${f#./}" <<<"$keep" || rm -f "$f"; done
gh release view packages -R dork40/arch-repo >/dev/null 2>&1 ||
    gh release create packages -R dork40/arch-repo --title "Packages" --notes "Pacman repo files. See the README to use it."
for old in $(gh release view packages -R dork40/arch-repo --json assets -q '.assets[].name'); do
    [[ -f $old ]] || gh release delete-asset packages "$old" -R dork40/arch-repo -y
done
gh release upload packages -R dork40/arch-repo --clobber dork40.db dork40.files dork40.db.tar.gz dork40.files.tar.gz ./*.pkg.tar.zst
echo "published: $(ls ./*.pkg.tar.zst | xargs -n1 basename | tr '\n' ' ')"
