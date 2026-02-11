{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.niri";
  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.niri.enable = true;
    services = {
      xserver.enable = true;
      displayManager = {
        ly.enable = true;
        defaultSession = "niri";
      };
    };
  };

  home.ifEnabled = {
    programs.fuzzel.enable = true;
    programs.waybar.enable = true;
    home.packages = with pkgs; [
      mako
      xwayland-satellite
      swaybg
    ];
  };
}
