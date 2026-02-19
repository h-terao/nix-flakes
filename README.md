# Nix Flakes

My NixOS and home-manager configurations, relying on [Flakes](https://wiki.nixos.org/wiki/Flakes) and [Denix](https://github.com/yunfachi/denix).

**Highlights:**

- Secure encryption with LUKS and TPM2
- Denix-style modular configuration
- Custom packages, including `playwright-cli`.

## Appendix

### Decrypting Encrypted Disks with TPM2

LUKS encrypted disks can be automatically decrypted at boot using TPM2. This setup enhances security by tying disk decryption to the specific hardware, preventing unauthorized access if the disk is removed.

To enroll a disk for TPM2-based decryption, use the following command on the target host:

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  --wipe-slot=tpm2 \
  /dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Replace with your disk's UUID
```

> [!NOTE]
> Your disk's UUID can be found in `hardware-configuration.nix`.

## Monitor Setup

- Run `niri msg outputs` and check resolution and refresh rate of your monitors
- Update `output` entries in `.config/niri/config.kdl`
