{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.claude-desktop";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.default ];
  };
}
