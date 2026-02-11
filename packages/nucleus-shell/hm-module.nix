{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.programs.nucleus-shell;
  nucleus-shell-pkg = pkgs.callPackage ./default.nix { };
in
{
  options.programs.nucleus-shell = {
    enable = mkEnableOption "nucleus-shell";

    package = mkOption {
      type = types.package;
      default = nucleus-shell-pkg;
      description = "The nucleus-shell package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (quickshell.withModules [
        qt6Packages.qtmultimedia
        qt6Packages.qt5compat
        qt6Packages.qtsvg
        qt6Packages.qtimageformats
      ])
      upower
      ddcutil
      material-symbols
      google-fonts
    ];

    xdg.configFile."quickshell/nucleus-shell" = {
      source = "${cfg.package}/share/nucleus-shell";
      recursive = true;
    };
  };
}
