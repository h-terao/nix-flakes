{
  delib,
  pkgs,
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
          extensions.autoCheckUpdates = false;
          extensions.autoUpdate = false;
          update.mode = "none";

          editor.fontFamily = "'PlemolJP', 'NotoMono Nerd Font'";
          editor.fontSize = 18;
          editor.formatOnSave = true;
          explorer.confirmDragAndDrop = false;
        };

        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
          # Language Pack
          ms-ceintl.vscode-language-pack-ja
          # Programming
          ms-python.python
          charliermarsh.ruff
          # denoland.vscode-deno
          jnoortheen.nix-ide
          # AI
          github.copilot
          anthropic.claude-code
        ];

        keybindings = [
          {
            key = "ctrl+space";
            command = "-editor.action.triggerSuggest";
            when = "editorHasCompletionItemProvider && textInputFocus && !editorReadonly && !suggestWidgetVisible";
          }
        ];
      };
    };
  };
}
