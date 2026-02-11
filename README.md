## TODO

- Set mise settings: `all_compile=false` to avoid all build.
- TPM2.0

TPM2を使ってディスク暗号の自動解錠を行う場合、以下のコマンドを実行すること。
ただし、デバイス名の部分は hardware-configuration.nix から取得する必要がある。

```bash
sudo systemd-cryptenroll \
  --tpm2-device=auto \
  --tpm2-pcrs=0+7 \
  --wipe-slot=tpm2 \
  /dev/disk/by-uuid/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

## Monitor Setup

- Move `.config/niri/config.kdl`
- Run `niri msg outputs` and updatee `output` lines in `config.kdl`. Mode must
  be exact match including resolution and frush rate

## Acknowledgements

- [nucleus-shell](https://github.com/xZepyx/nucleus-shell)