{ self, ... }:
let
  inherit (self) mkModules;
in
{
  flake.darwinModules = mkModules {
    nixpkgs = import ./nixpkgs.nix;
  };
}
