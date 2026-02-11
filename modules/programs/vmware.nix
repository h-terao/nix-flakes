{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.vmware";
  options = delib.singleEnableOption true;

  nixos.ifEnabled = {
    virtualisation.vmware.host.enable = true;
  };

  darwin.ifEnabled = {
    virtualisation.vmware.host.enable = true;
  };
}
