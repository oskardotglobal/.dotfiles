{
  flake.nixosModules' = {
    nixpkgs = ./nixpkgs.nix;
    home = ./home.nix;

    hardware.superdrive = ./hardware/superdrive.nix;

    system = {
      cups = ./system/cups.nix;
      gnome = ./system/gnome.nix;
      l10n = ./system/l10n.nix;
      networking = ./system/networking.nix;
      sound = ./system/sound.nix;
      swapfile = ./system/swapfile.nix;
    };

    programs = {
      animalese-typing = ./programs/animalese-typing.nix;
      shell-tooling = ./programs/shell-tooling.nix;
      nix-dev = ./programs/nix-dev.nix;
      work = ./programs/work.nix;
      nh = ./programs/nh.nix;
      ssh = ./programs/ssh.nix;
      syncthing = ./programs/syncthing.nix;
      winapps = ./programs/winapps.nix;
    };
  };
}
