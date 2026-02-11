{
  description = "NixOS configurations with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nix-vscode-extensions,
      quickshell,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nix-vscode-extensions.overlays.default
          quickshell.overlays.default
        ];
      };
    in
    {
      packages.${system} = {
        nucleus-shell = pkgs.callPackage ./packages/nucleus-shell { };
      };

      homeManagerModules = {
        nucleus-shell = import ./packages/nucleus-shell/hm-module.nix;
      };

      nixosConfigurations = {
        hippo = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { ... }:
              {
                nixpkgs = {
                  config.allowUnfree = true;
                  overlays = [
                    nix-vscode-extensions.overlays.default
                    quickshell.overlays.default
                  ];
                };
              }
            )

            ./users/hayato/system.nix
            ./hosts/hippo/configuration.nix
            ./modules/system/profiles/desktop.nix

            home-manager.nixosModules.home-manager
            (
              { ... }:
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit inputs; };
                home-manager.users.hayato = import ./users/hayato/home.nix;
              }
            )
          ];
        };
      };
    };
}
