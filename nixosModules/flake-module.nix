_: {
  flake.nixosModules' = {
    nixpkgs = ./nixpkgs.nix;
    hardware = {
      superdrive = ./hardware/superdrive.nix;
    };

    system = {
      cups = ./system/cups.nix;
      gnome = ./system/gnome.nix;
      l10n = ./system/l10n.nix;
      networking = ./system/networking.nix;
      sound = ./system/sound.nix;
      swapfile = ./system/swapfile.nix;
      user = ./system/user.nix;
    };

    programs = {
      games = {
        default = ./programs/games;
        steam = ./programs/games/steam.nix;
      };

      programming = {
        tooling = ./programs/programming/tooling.nix;
        docker = ./programs/programming/docker.nix;
        nix = ./programs/programming/nix.nix;
        work = ./programs/programming/work.nix;
      };

      direnv = ./programs/direnv.nix;
      nh = ./programs/nh.nix;
      other = ./programs/other.nix;
      ssh = ./programs/ssh.nix;
      syncthing = ./programs/syncthing.nix;
      winapps = ./programs/winapps.nix;
      zsh = ./programs/zsh.nix;
    };
  };
}
