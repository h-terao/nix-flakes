{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.nemo";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    services.gvfs.enable = true;
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      nemo-with-extensions
    ];
  };
}
