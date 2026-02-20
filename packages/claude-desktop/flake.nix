{
  description = "Claude Desktop - Linux (unofficial, from official binary)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      mkClaudeDesktop =
        pkgs:
        pkgs.stdenv.mkDerivation rec {
          pname = "claude-desktop";
          version = "1.1.3647";

          src = pkgs.fetchurl {
            url = "https://github.com/patrickjaja/claude-desktop-bin/releases/download/v${version}/claude-desktop-${version}-linux.tar.gz";
            sha256 = "sha256-4mO2JUrR4CvMNsCcSq37/PlNRmCHmh4Ummuk4kWmoZE=";
          };

          nativeBuildInputs = [ pkgs.makeWrapper ];

          buildInputs = [
            pkgs.electron
            pkgs.nodejs
          ];

          dontBuild = true;
          dontConfigure = true;

          unpackPhase = ''
            mkdir -p source
            tar -xzf $src -C source
          '';

          installPhase = ''
                      runHook preInstall

                      # Install application files
                      mkdir -p $out/lib/claude-desktop
                      cp -r source/app/* $out/lib/claude-desktop/

                      # Install launcher script
                      mkdir -p $out/bin
                      makeWrapper ${pkgs.electron}/bin/electron $out/bin/claude-desktop \
                        --add-flags "$out/lib/claude-desktop/app.asar"

                      # Install desktop entry
                      mkdir -p $out/share/applications
                      cat > $out/share/applications/claude-desktop.desktop << 'EOF'
            [Desktop Entry]
            Name=Claude
            Comment=Claude AI Desktop Application
            Exec=claude-desktop %u
            Icon=claude-desktop
            Type=Application
            Terminal=false
            Categories=Office;Utility;Chat;
            MimeType=x-scheme-handler/claude;
            StartupWMClass=Claude
            EOF

                      # Install icon
                      if [ -f "source/icons/claude-desktop.png" ]; then
                        mkdir -p $out/share/icons/hicolor/256x256/apps
                        cp source/icons/claude-desktop.png $out/share/icons/hicolor/256x256/apps/claude-desktop.png
                      fi

                      runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "Claude Desktop - Linux (unofficial, from official binary)";
            homepage = "https://claude.ai";
            license = licenses.unfree;
            platforms = [ "x86_64-linux" ];
            maintainers = [ ];
          };
        };
    in
    {
      overlays.default = final: prev: {
        claude-desktop = mkClaudeDesktop final;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        packages.claude-desktop = mkClaudeDesktop pkgs;
        packages.default = self.packages.${system}.claude-desktop;

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.claude-desktop;
          exePath = "/bin/claude-desktop";
        };
      }
    );
}
