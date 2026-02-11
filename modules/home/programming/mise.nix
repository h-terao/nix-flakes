{ config, pkgs, ... }:
{
  programs.fish.enable = true;
  programs.mise = {
    enable = true;
    enableFishIntegration = true;
    globalConfig.settings = {
      all_compile = false;
    };
  };
}
