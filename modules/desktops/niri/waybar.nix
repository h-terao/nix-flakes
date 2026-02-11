{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.niri.wayland";
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    programs.waybar = { };
  };
}
