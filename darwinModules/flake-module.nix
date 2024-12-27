{self, ...}: let
  inherit (self) mkModules;
in {
  perSystem = {...}: {};
  flake.darwinModules = mkModules {
    nixpkgs = import ./nixpkgs.nix;
  };
}
