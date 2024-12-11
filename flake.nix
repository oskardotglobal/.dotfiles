{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming/8756862665662edad5bbb098d0cba727cde57fec";
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
      url = "github:ch4og/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nur,
    rust-overlay,
    zen-browser,
    winapps,
    home-manager,
    ...
  } @ inputs: rec {
    overlays = {
      spotx = import ./overlays/spotx.nix;
      git-blame-someone-else = import ./overlays/git-blame-someone-else.nix;
    };

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
            config.permittedInsecurePackages = ["qbittorrent-4.6.4"];

            overlays = [
              nur.overlay
              rust-overlay.overlays.default
              overlays.spotx
              overlays.git-blame-someone-else
              (final: prev: {
                zen-browser = prev.lib.makeOverridable zen-browser.packages."${system}".specific;

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
          ({inputs, ...}: {
            # make `nix run nixpkgs#package` use the same nixpkgs as the one used by this flake.
            nix.registry.nixpkgs.flake = inputs.nixpkgs;

            # remove nix-channel related tools & configs, we use flakes instead.
            nix.channel.enable = false;

            # Keep nixPath so we don't have to use flakes for dev shells
            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
              "nixpkgs-unstable=${inputs.nixpkgs-unstable}"
              "rust-overlay=${inputs.rust-overlay}"
            ];
          })

          home-manager.nixosModules.home-manager
          ./configuration.nix
        ];
      };
  };
}
