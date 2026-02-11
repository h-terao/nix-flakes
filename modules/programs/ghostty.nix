{
  delib,
  ...
}:
delib.module {
  name = "programs.ghostty";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      settings = {
        font-family = "PlemolJP Console Light";
        font-size = 12;
      };
    };
  };
}
