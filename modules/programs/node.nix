{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.node";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    environment.systemPackages = [ pkgs.nodejs ];
  };
}
