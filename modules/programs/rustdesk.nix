{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.rustdesk";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      rustdesk-flutter
    ];
  };
}
