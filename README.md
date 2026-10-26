# SilverNebula

> Official package repository for SilverArch Linux.

![license](https://img.shields.io/badge/license-GPL--v3.0-00FF7F?style=flat-square)
![arch](https://img.shields.io/badge/arch-x86__64-1793D1?style=flat-square&logo=archlinux&logoColor=white)
![status](https://img.shields.io/badge/status-alpha-FFD700?style=flat-square)

SilverNebula is a pacman repository that ships the SilverArch tools, signed with the SilverNebula GPG key.

## Packages

| Package | Description |
|---------|-------------|
| `silvernebula-keyring` | GPG keyring for this repo |
| `silversaphire` | SilverSaphire (`ss`): SilverArch installer |
| `slite` | Rootless container engine |
| `silvergrab` | Package manager (pacman wrapper) |
| `silverflux` | Sync tool: pacman + AUR + mirrors |
| `silverpurge` | System cleanup |

## Using the repo

Add this to `/etc/pacman.conf`:

```ini
[silvernebula]
SigLevel = Required DatabaseOptional
Server   = https://raw.githubusercontent.com/s1lverarch/silvernebula/main/$arch
```

Then install the keyring first, and sync:

```bash
sudo pacman -Sy silvernebula-keyring
sudo pacman -Syu
```

## Repository layout

```
x86_64/
├── silvernebula.db.tar.gz       package database
├── silvernebula.files.tar.gz    file list
└── *.pkg.tar.zst (+ .sig)       packages and signatures
```

## Building

Each package has its own PKGBUILD. `build-repo.sh` builds, signs and indexes every package:

```bash
export SN_KEY=<master fingerprint>
./build-repo.sh
```

## Security

- Packages and the database are signed with the SilverNebula master key.
- Never commit the private key (`*.priv.asc`) to this repository.
- Compromised keys are listed in `silvernebula-revoked` through the keyring package.

## Author

**Silvercore (s1lverarch)**
- Email: s1lv3rcore@proton.me
- Website: https://s1lverarch.github.io/linuxdistro/
- GitHub: https://github.com/s1lverarch

## License

GPL-3.0. See [LICENSE](LICENSE).

---

**SilverArch Linux Project**: Made With Love In Tunisia
