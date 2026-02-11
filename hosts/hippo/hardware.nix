{
  delib,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
delib.host {
  name = "hippo";

  system = "x86_64-linux";

  useHomeManagerModule = true;
  home.home.stateVersion = "25.11";

  # If you're not using NixOS, you can remove this entire block.
  nixos = {
    system.stateVersion = "25.11";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "thunderbolt"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/luks-0b69bffa-7e53-4f67-99bc-1ec35c12e4c1";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-0b69bffa-7e53-4f67-99bc-1ec35c12e4c1".device =
      "/dev/disk/by-uuid/0b69bffa-7e53-4f67-99bc-1ec35c12e4c1";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/32BE-A25B";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # If you're not using Nix-Darwin, you can remove this entire block.
  darwin = {
    system.stateVersion = 6; # !!! REPLACEME
  };
}
