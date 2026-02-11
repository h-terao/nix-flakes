{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.google-chrome";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      google-chrome
    ];
  };
}
