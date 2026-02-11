{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fish";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      fish
    ];
  };
}
