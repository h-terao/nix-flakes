{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktop.ly";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.displayManager.ly.enable = true;
  };
}
