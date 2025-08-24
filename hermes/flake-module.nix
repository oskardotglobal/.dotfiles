{
  self,
  inputs,
  ...
}:
let
  host = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = rec {
      system = "aarch64-darwin";

      inherit inputs self;
      inherit (self) homeModules;
    };

    modules = with self; [
      inputs.home-manager.darwinModules.home-manager

      nixosModules'.nixpkgs
      nixosModules'.home

      nixosModules'.programs.shell-tooling
      nixosModules'.programs.nix-dev

      ./configuration.nix
    ];
  };
in
{
  flake.darwinConfigurations = {
    hermes = host;
    "Air-von-Oskar" = host;
  };
}
