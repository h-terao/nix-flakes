{ pkgs, ... }:
{
  security.polkit.enable = true;
  services.dbus.enable = true;
  environment.systemPackages = with pkgs; [
    polkit
    lxqt.lxqt-policykit
  ];
}
