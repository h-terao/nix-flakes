{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop.swaync";
  options = delib.singleEnableOption true;

  home.ifEnabled = {

    # 設定ボタンで呼ぶGUI等
    home.packages = with pkgs; [
      networkmanagerapplet # nm-connection-editor
      blueman # blueman-manager
    ];

    services.swaync = {
      enable = true;

      style = ''
        /* widgets 間の余白 */
        .control-center .widget-title,
        .control-center .widget-buttons-grid {
          margin-top: 24px;
          margin-bottom: 18px;
        }

        /* volume label size */
        .control-center .widget-volume label {
          font-size: 24px;
        }

        /* button grid label size */
        .control-center .widget-buttons-grid button,
        .control-center .widget-buttons-grid button label {
          font-size: 24px;
        }
      '';

      settings = {
        # 右上に出す（Waybarの高さ+上マージン分だけ下げる）
        control-center-positionX = "right";
        control-center-positionY = "top";
        control-center-margin-top = 10;
        control-center-margin-right = 12;
        control-center-width = 480;
        control-center-height = 700;
        fit-to-screen = false;

        widgets = [
          "buttons-grid"
          "mpris"
          "volume"
          "title"
          "notifications"
        ];

        widget-config = {
          title = {
            text = "Notifications";
            clear-all-button = true;
          };
          volume = {
            label = "󰕾";
          };
          buttons-grid = {
            buttons-per-row = 4;
            actions = [
              {
                label = "";
                command = "nm-connection-editor";
              }
              {
                label = "";
                command = "blueman-manager";
              }
              {
                label = "󰜉";
                command = "systemctl reboot";
              }
              {
                label = "󰤆";
                command = "systemctl poweroff";
              }
            ];
          };
        };
      };
    };
  };
}
