{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nautilus
  ];
  programs.dconf.enable = true;
  services.gvfs.enable = true;
}
