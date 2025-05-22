{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.ares = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      system = "x86_64-linux";

      inherit inputs self;

      inherit (inputs) nix-citizen nix-gaming;
      inherit (self) homeModules;
    };

    modules = with self; [
      nixosModules'.nixpkgs
      nixosModules'.home

      nixosModules'.programs.animalese-typing
      nixosModules'.programs.nix-dev
      nixosModules'.programs.shell-tooling
      nixosModules'.programs.ssh
      nixosModules'.programs.work
      nixosModules'.programs.syncthing

      nixosModules'.system.cups
      nixosModules'.system.gnome
      nixosModules'.system.l10n
      nixosModules'.system.networking
      nixosModules'.system.sound
      nixosModules'.system.swapfile

      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
