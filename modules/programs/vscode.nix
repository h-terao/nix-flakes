{
  delib,
  pkgs,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.vscode";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;

      profiles.default = {
        userSettings = {
          "extensions.autoCheckUpdates" = false;
          "extensions.autoUpdate" = false;
          "update.mode" = "none";

          "editor.fontFamily" = "PlemolJP";
          "editor.fontSize" = 18;
          "editor.formatOnSave" = true;

          "workbench.colorTheme" = "Ra Spring";
        };

        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
          # Theme
          rahmanyerli.ra-spring
          # Language Pack
          ms-ceintl.vscode-language-pack-ja
          # Programming
          ms-python.python
          # denoland.vscode-deno
          jnoortheen.nix-ide
          # AI
          github.copilot
          anthropic.claude-code
        ];
      };
    };
  };
}
