{
  description = "sticker.webp";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem
    (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (pkgs) stdenv;
    in {
      packages = {
        default = stdenv.mkDerivation rec {
          name = "sticker.webp";

          buildInputs = with pkgs; [
            bash
            coreutils-full
            gnused
            procps
            gnugrep
            gawk
            findutils
            libsixel
          ];

          src = ./.;

          dontBuild = true;
          installPhase = ''
            runHook preInstall
            install -Dm755 -t $out/bin ${name}
            runHook postInstall
          '';
        };
      };

      apps.default = utils.lib.mkApp {drv = self.packages.${system}.default;};
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [kitty kdePackages.konsole libsixel];
      };
    });
}
