# Nix Configurations

This repository contains my NixOS and home configurations, primarily powered by [Flakes](https://wiki.nixos.org/wiki/Flakes) and [Denix](https://github.com/yunfachi/denix).

## Note

At the moment, nixos-rebuild does not configure everything end-to-end. Some steps still require manual setup (see below).

### Disk auto-unlock with TPM

To enroll a LUKS device for automatic decryption via TPM2:

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  --wipe-slot=tpm2 \
  /dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

Replace the UUID with the one found in the target host's hardware-configuration.nix.

## Monitor Setup

- Run `niri msg outputs` and check resolution and refresh rate of your monitors
- Update `output` entries in `.config/niri/config.kdl`
