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
      nixosModules'.nixpkgs
      nixosModules'.programs.direnv
      nixosModules'.programs.games.default
      nixosModules'.programs.games.steam
      nixosModules'.programs.nh
      nixosModules'.programs.other
      nixosModules'.programs.programming.docker
      nixosModules'.programs.programming.nix
      nixosModules'.programs.programming.tooling
      nixosModules'.programs.programming.work
      nixosModules'.programs.ssh
      nixosModules'.programs.syncthing
      nixosModules'.programs.winapps
      nixosModules'.programs.zsh
      nixosModules'.system.cups
      nixosModules'.system.gnome
      nixosModules'.system.l10n
      nixosModules'.system.networking
      nixosModules'.system.sound
      nixosModules'.system.swapfile
      nixosModules'.system.user

      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
