{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.claude-code";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      claude-code
    ];
  };
}
