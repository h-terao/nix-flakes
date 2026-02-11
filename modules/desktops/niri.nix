{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "desktops.niri-old";
  options = delib.singleEnableOption false;
  nixos.ifEnabled = {
    programs.niri.enable = true;
    services = {
      xserver.enable = true;
      displayManager = {
        gdm.enable = true;
        defaultSession = "niri";
      };
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      mako
      fuzzel
      ghostty
      xwayland-satellite
      adwaita-icon-theme
      swaybg
      # Nucleus shell
      upower
      ddcutil
      material-symbols
      google-fonts
      (quickshell.withModules [
        qt6Packages.qtmultimedia
        qt6Packages.qt5compat
        qt6Packages.qtsvg
        qt6Packages.qtimageformats
      ])
    ];
  };
}
