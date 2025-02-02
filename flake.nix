{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ]
          f;
    in
    {
      devShells = eachSystem (
        system: with nixpkgs.legacyPackages.${system}; {
          default = mkShell {
            packages = [
              cargo
              rust-analyzer
              rustfmt
              rustc
              postgresql
            ];
            RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
          };
        }
      );
    };
}
