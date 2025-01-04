{
  self,
  inputs,
  ...
}:
{
  perSystem = { ... }: { };
  flake.darwinConfigurations."Air-von-Oskar" = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = rec {
      system = "aarch64-darwin";

      inherit inputs self;
      inherit (self) homeModules nixosModules darwinModules;

      pkgs = import inputs.nixpkgs-darwin {
        inherit system;
        config.allowUnfree = true;

        overlays = [ ];
      };
    };

    modules = [
      inputs.home-manager.darwinModules.home-manager
      ./configuration.nix
    ];
  };
}
