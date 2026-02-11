{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop.waybar";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [ pkgs.playerctl ];
    programs.waybar = {
      enable = true;
      style = ''
        * {
          font-family: "NotoSansM Nerd Font", "Noto Sans CJK JP", sans-serif;
          font-size: 16px;
        }

        window#waybar { background: transparent; }

        #waybar .modules-left,
        #waybar .modules-center,
        #waybar .modules-right {
          border-radius: 999px;
          padding: 0 12px;
        }

        #waybar .modules-left  { margin-left: 12px; }
        #waybar .modules-right { margin-right: 12px; }
        #waybar .modules-center { margin: 0 8px; }

        #waybar .module { padding: 0 8px; }
      '';
      settings = {
        statusBar = {
          layer = "top";
          position = "top";
          height = 30;
          margin-top = 8;
          # output = ["eDP-1" "HDMI-A-1"];
          modules-left = [
            # "niri/workspaces"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "custom/fcitx5"
            "custom/control-panel"
          ];
          clock = {
            interval = 60;
            format = "{:%I:%M %p %a %b %d}";
            max-length = 50;
          };
          "custom/fcitx5" = {
            format = "{}";
            exec = "${pkgs.writeShellScript "waybar-fcitx5" ''
              name="$(fcitx5-remote -n)"
              case "$name" in
                *mozc*|*Mozc*) echo "あ" ;;
                *keyboard-us*|*English*US*|*US*) echo "en" ;;
                *) echo "N/A" ;;
              esac
            ''}";
            interval = 1;
            tooltip = false;
          };
          "custom/control-panel" = {
            format = "";
            tooltip = false;
            "on-click" = "swaync-client -t -sw";
          };
        };
      };
    };
  };
}
