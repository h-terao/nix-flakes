{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.obsidian";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.obsidian = {
      enable = true;
      package = pkgs.obsidian;
    };
  };
}
