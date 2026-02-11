{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.node";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      nodejs
    ];
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      nodejs
    ];
  };
}
