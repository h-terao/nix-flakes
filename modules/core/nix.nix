{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "core.nix";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
    };

    boot.loader.systemd-boot.configurationLimit = 5;
    boot.tmp.cleanOnBoot = true;

    environment.systemPackages = with pkgs; [
      nixfmt
    ];
  };
}
