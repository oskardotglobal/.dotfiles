{ self, ... }:
{
  flake.darwinModules = {
    nixpkgs = ./nixpkgs.nix;
  };
}
