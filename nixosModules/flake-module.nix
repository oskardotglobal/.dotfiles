{self, ...}: let
  inherit (self) mkModules;
in {
  flake.nixosModules' = mkModules {
    nixpkgs = import ./nixpkgs.nix;

    hardware = mkModules {
      superdrive = import ./hardware/superdrive.nix;
    };

    system = mkModules {
      cups = import ./system/cups.nix;
      gnome = import ./system/gnome.nix;
      l10n = import ./system/l10n.nix;
      networking = import ./system/networking.nix;
      sound = import ./system/sound.nix;
      swapfile = import ./system/swapfile.nix;
      user = import ./system/user.nix;
    };

    programs = mkModules {
      games = mkModules {
        default = import ./programs/games;
        steam = import ./programs/games/steam.nix;
      };

      programming = mkModules {
        tooling = import ./programs/programming/tooling.nix;
        docker = import ./programs/programming/docker.nix;
        nix = import ./programs/programming/nix.nix;
        work = import ./programs/programming/work.nix;
      };

      direnv = import ./programs/direnv.nix;
      nh = import ./programs/nh.nix;
      other = import ./programs/other.nix;
      ssh = import ./programs/ssh.nix;
      syncthing = import ./programs/syncthing.nix;
      winapps = import ./programs/winapps.nix;
      zsh = import ./programs/zsh.nix;
    };
  };
}
