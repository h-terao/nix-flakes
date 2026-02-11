{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "nucleus-shell";
  version = "unstable-2026-02-10";

  src = fetchFromGitHub {
    owner = "xZepyx";
    repo = "nucleus-shell";
    rev = "main";
    hash = "sha256-fc7SPgSIOJ9zl+G+KOr+f3CEx+Rok3bzVQGfyfZ3ACU=";
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/nucleus-shell
    cp -r quickshell/nucleus-shell/* $out/share/nucleus-shell/
    runHook postInstall
  '';

  meta = with lib; {
    description = "A QuickShell-based desktop shell";
    homepage = "https://github.com/xZepyx/nucleus-shell";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
