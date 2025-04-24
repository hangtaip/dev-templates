{
  description = "A Nix-flake based Dotnet development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url ="github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
          devShells.default =  pkgs.mkShell{
            buildInputs = with pkgs; [
              dotnet-sdk_10
              nss_latest
          ];

          shellHook = ''
            echo "dotnet development environment loaded!"
          '';
        };
      });
}
