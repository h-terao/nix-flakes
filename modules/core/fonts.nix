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
        noto-fonts
        noto-fonts-cjk-serif
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        plemoljp
        nerd-fonts.noto
      ];
      # fontDir.enable = true;
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "Noto Serif"
            "Noto Serif CJK JP"
            "Noto Color Emoji"
          ];
          sansSerif = [
            "Noto Sans"
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

  home.ifEnabled = {
    # GTK font settings
    gtk = {
      enable = true;
      font = {
        name = "Noto Sans";
        size = 11;
      };
    };

    # dconf font settings for GTK applications
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        font-name = "Noto Sans 11";
        monospace-font-name = "PlemolJP Console 11";
      };
    };
  };
}
