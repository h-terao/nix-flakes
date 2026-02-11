{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.username = "hayato";
  home.homeDirectory = "/home/hayato";
  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nano";
  };

  imports = [
    ../../modules/home/profiles/desktop.nix
  ];
}
