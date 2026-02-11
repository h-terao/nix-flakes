{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
  ];

  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "h-terao";
        email = "h-terao@ymail.ne.jp";
      };
    };
  };
}
