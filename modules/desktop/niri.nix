{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop.niri";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    programs.niri.enable = true;
    services = {
      xserver.enable = true;
      displayManager = {
        defaultSession = "niri";
      };
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      # mako
      xwayland-satellite
      swaybg
    ];
  };
}
