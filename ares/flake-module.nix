{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.ares = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = rec {
      system = "x86_64-linux";

      inherit inputs self;

      inherit (inputs) nix-citizen nix-gaming;
      inherit (self) homeModules;

      nix-jetbrains-plugins = inputs.nix-jetbrains-plugins.plugins."${system}";
    };

    modules = with self; [
      nixosModules'.nixpkgs
      nixosModules'.home

      nixosModules'.steambox

      nixosModules'.programs.animalese-typing
      nixosModules'.programs.nix-dev
      nixosModules'.programs.shell-tooling
      nixosModules'.programs.ssh
      nixosModules'.programs.work
      nixosModules'.programs.syncthing
      nixosModules'.programs.idea

      nixosModules'.system.cups
      nixosModules'.system.gnome
      nixosModules'.gnome-rdp
      nixosModules'.system.l10n
      nixosModules'.system.networking
      nixosModules'.system.sound

      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
