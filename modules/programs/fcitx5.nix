{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.fcitx5";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    i18n = {
      inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = [ pkgs.fcitx5-mozc ];
      };
    };
  };
}
