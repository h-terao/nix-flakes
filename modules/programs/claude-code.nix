{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.claude-code";
  options = delib.singleEnableOption true;

  home.ifEnabled = {
    nixpkgs.overlays = [ inputs.claude-code.overlays.default ];
    programs.claude-code = {
      enable = true;
    };
  };
}
