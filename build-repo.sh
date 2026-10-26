
#!/usr/bin/env bash
# build-repo.sh — builds every SilverArch package, signs it, and updates the SilverNebula db.
set -euo pipefail

PROJECTS="$HOME/Projects"
REPO="$HOME/Projects/silvernebula/x86_64"
FPR="${SN_KEY:?set SN_KEY to your master fingerprint}"

# package-name:folder-in-Projects
PKGS=(
  "silvernebula-keyring:silvernebula-keyring"
  "silversaphire:SilverSaphire"
  "slite:slite"
  "silvergrab:silvergrab"
  "silverflux:silverflux"
  "silverpurge:silverpurge"
)

mkdir -p "$REPO"

for entry in "${PKGS[@]}"; do
  name="${entry%%:*}"
  folder="${entry##*:}"
  dir="$PROJECTS/$folder"

  if [[ ! -f "$dir/PKGBUILD" ]]; then
    echo "!! skip $name: no PKGBUILD in $dir"
    continue
  fi

  echo "==> building $name"
  (cd "$dir" && makepkg -sf --sign --key "$FPR" --noconfirm)
  cp -v "$dir"/*.pkg.tar.zst "$REPO"/
  cp -v "$dir"/*.pkg.tar.zst.sig "$REPO"/ 2>/dev/null || true
done

cd "$REPO"
echo "==> updating database"
rm -f silvernebula.db* silvernebula.files*
repo-add --sign --key "$FPR" silvernebula.db.tar.gz ./*.pkg.tar.zst
ls -lh
