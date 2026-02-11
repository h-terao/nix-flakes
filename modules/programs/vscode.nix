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

          github.copilot = {
            enable = {
              "*" = true;
              markdown = true;
              plaintext = false;
              scminput = false;
            };
            nextEditSuggestions.enabled = true;
          };
        };

        extensions = (with pkgs.nix-vscode-extensions.vscode-marketplace; [
          # Language Pack
          ms-ceintl.vscode-language-pack-ja
          # AI
          github.copilot
          anthropic.claude-code
          # Python
          ms-python.python
          # ms-python.vscode-pylance
          charliermarsh.ruff
          # Nix
          jnoortheen.nix-ide
        ])
        ++ 
        (with pkgs.vscode-extensions; [
	  ms-python.vscode-pylance
        ]);

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
