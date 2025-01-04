{
  self,
  inputs,
  ...
}:
{
  perSystem = { ... }: { };
  flake.nixosConfigurations.ares = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = rec {
      system = "x86_64-linux";

      inherit inputs;
      inherit (inputs) nix-citizen nix-gaming;

      inherit (self) nixosModules homeModules;

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "qbittorrent-4.6.4"
          "electron-25.9.0"
        ];

        overlays = [
          inputs.nur.overlays.default
          inputs.rust-overlay.overlays.default

          self.overlays.spotx
          self.overlays.git-blame-someone-else

          (_: pkgs: {
            inherit (inputs.winapps.packages."${system}") winapps winapps-launcher;
          })
        ];
      };

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    modules = [
      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
