{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.ares = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = rec {
      system = "x86_64-linux";

      inherit inputs;
      inherit (inputs) nix-citizen nix-gaming;

      inherit (self) homeModules;

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "qbittorrent-4.6.4"
          "electron-25.9.0"
        ];

        overlays = [
          inputs.nur.overlay
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

    modules = with self; [
      nixosModules'.hardware.superdrive
      nixosModules'.system
      nixosModules'.programs
      nixosModules'.nixpkgs

      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
