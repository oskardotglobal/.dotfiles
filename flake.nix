{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.url = "github:LovingMelody/nix-citizen";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # updates underlying without waiting for nix-citizen to update
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  } @ inputs: {
    nixosConfigurations.ares = let
      system = "x86_64-linux";
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit (inputs) nixpkgs-unstable nix-citizen nix-gaming;

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;

            overlays = [
              self.inputs.rust-overlay.overlays.default
              (final: prev: {
                spotify = prev.callPackage ./packages/spotify {};
              })
            ];
          };

          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          ./configuration.nix
        ];
      };
  };
}
