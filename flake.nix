{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps/7f3cdcee4d209e2187d006fa6846f3d332f6fc77";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nur,
    rust-overlay,
    zen-browser,
    stylix,
    winapps,
    home-manager,
    ...
  } @ inputs: rec {
    overlays.spotx = import ./default.nix;

    nixosConfigurations.ares = let
      system = "x86_64-linux";
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit (inputs) nix-citizen nix-gaming;

          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;

            overlays = [
              nur.overlay
              rust-overlay.overlays.default
              overlays.spotx
              (final: prev: {
                zen-browser = zen-browser.packages."${system}".specific;

                winapps = winapps.packages."${system}".winapps;
                winapps-launcher = winapps.packages."${system}".winapps-launcher;
              })
            ];
          };

          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
  };
}
