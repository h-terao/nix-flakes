{
  inputs,
  config,
  pkgs,
  ...
}:
{
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
}
