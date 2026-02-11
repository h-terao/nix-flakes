{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.github-cli";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      gh
    ];
  };
}
