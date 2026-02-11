{
  delib,
  inputs,
  ...
}:
let
  pkgs-overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.quickshell.overlays.default
  ];
in
delib.module {
  name = "core.nixpkgs";

  nixos.always = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = pkgs-overlays;
    };
  };

  home.always = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = pkgs-overlays;
    };
  };
}
