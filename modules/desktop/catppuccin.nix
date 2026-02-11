{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "desktop.catppuccin";
  options = delib.singleEnableOption true;

  home.always.imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.ifEnabled =
    let
      # latte, frappe, macchiato, mocha
      flavor = "latte";
      editorFlavor = "latte";
      terminalFlavor = "frappe";
    in
    {
      catppuccin = {
        enable = true;

        # Global flavor
        flavor = flavor;
        cursors.enable = true;
        gtk.icon.enable = true;

        # Editor flavor
        vscode.profiles.default = {
          flavor = editorFlavor;
          icons.flavor = editorFlavor;
        };

        # Terminal fravor
        ghostty.flavor = terminalFlavor;
        yazi.flavor = terminalFlavor;
        fish.flavor = terminalFlavor;
        bat.flavor = terminalFlavor;
        eza.flavor = terminalFlavor;

        # Apply catppuccin theme to swaync
        swaync.enable = false;
      };
    };
}
