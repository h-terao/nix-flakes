{
  description = "Packaged @playwright/cli for Nix/NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      mkPlaywrightCli = pkgs: pkgs.buildNpmPackage rec {
        pname = "playwright-cli";
        version = "0.1.1";

        src = pkgs.fetchFromGitHub {
          owner = "microsoft";
          repo = "playwright-cli";
          rev = "v${version}";
          hash = "sha256-Ao3phIPinliFDK04u/V3ouuOfwMDVf/qBUpQPESziFQ=";
        };

        npmDepsHash = "sha256-4x3ozVrST6LtLoHl9KtmaOKrkYwCK84fwEREaoNaESc=";

        nativeBuildInputs = [ pkgs.makeWrapper ];

        env.PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";

        npmInstallFlags = [ "--ignore-scripts" ];

        dontNpmBuild = true;

        postFixup = ''
          chromiumPath=$(find -L ${pkgs.playwright-driver.browsers} -maxdepth 1 -name "chromium-*" | head -1)
          chromeBin=$(find -L "$chromiumPath" -name "chrome" -type f -executable | head -1)
          wrapProgram $out/bin/playwright-cli \
            --set PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD 1 \
            --set PLAYWRIGHT_BROWSERS_PATH ${pkgs.playwright-driver.browsers} \
            --set PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true \
            --set PLAYWRIGHT_HOST_PLATFORM_OVERRIDE ubuntu-24.04 \
            --set PLAYWRIGHT_MCP_EXECUTABLE_PATH "$chromeBin"
        '';
      };
    in
    {
      overlays.default = final: prev: {
        playwright-cli = mkPlaywrightCli final;
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.playwright-cli = mkPlaywrightCli pkgs;
        packages.default = self.packages.${system}.playwright-cli;

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.playwright-cli;
          exePath = "/bin/playwright-cli";
        };
      });
}
