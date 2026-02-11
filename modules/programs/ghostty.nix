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
        font-family = "PlemolJP Console NF";
        font-size = 12;
      };
    };
  };
}
