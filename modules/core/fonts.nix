{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "core.fonts";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    fonts = {
      packages = with pkgs; [
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        plemoljp
      ];
      # fontDir.enable = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "Noto Serif CJK JP"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "Noto Sans CJK JP"
            "Noto Color Emoji"
          ];
          monospace = [
            "PlemolJP Console"
            "Noto Color Emoji"
          ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
