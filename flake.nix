{
  description = "Aly's wallpaper collection.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = inputs @ {self, ...}: {
    formatter = inputs.nixpkgs.lib.genAttrs [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ] (system: inputs.nixpkgs.legacyPackages.${system}.alejandra);

    packages =
      inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ] (system: {
        default = inputs.nixpkgs.legacyPackages."${system}".stdenv.mkDerivation {
          name = "wallpapers";
          version = "0.1.0";
          src = ./.;
          installPhase = ''
            mkdir -p $out/share/backgrounds
            cp -r *.jpg $out/share/backgrounds
            cp -r *.png $out/share/backgrounds
          '';
        };
      });
  };
}
