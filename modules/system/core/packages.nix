{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt
  ];

  programs = {
    nix-ld = {
      enable = true;
    };
  };
}
