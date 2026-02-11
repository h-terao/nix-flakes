{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.mise";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [ nix-ld ];
  };

  home.ifEnabled = {
    programs.mise = {
      enable = true;
      enableFishIntegration = true;
      globalConfig.settings = {
        all_compile = false;
      };
    };
  };
}
