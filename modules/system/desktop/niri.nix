{ config, pkgs, ... }:
{
  programs.niri.enable = true;
  services = {
    xserver.enable = true;
    displayManager = {
      gdm.enable = true;
      defaultSession = "niri";
    };
  };
}
