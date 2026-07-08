{
  self,
  inputs,
  config,
  homeModules,
  pkgs,
  ...
}:
let
  inherit (config.oskardotglobal.home) username;
in
{
  imports = [
    ./hardware
    ./games
    ./kvm.nix
  ];

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    self.overlays.git-blame-someone-else
  ];

  networking = {
    hostName = "ares";

    interfaces.enp39s0.wakeOnLan = {
      enable = true;
      policy = [
        "phy"
        "magic"
      ];
    };
  };

  oskardotglobal.home = {
    username = "oskar";
    displayName = "Oskar Manhart";

    modules = [
      {
        home.homeDirectory = "/home/${username}";
        xdg.enable = true;
      }

      homeModules.kitty
      homeModules.firefox
      homeModules.git
      homeModules.zsh
      homeModules.helix
    ];

    stateVersion = "24.05";
  };

  users.users."${username}" = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  systemd = {
    services."home-manager-${username}".serviceConfig.ExecStartPre =
      let
        script = pkgs.writeScript "hm-${username}-pre-start" ''
          #!${pkgs.bash}/bin/bash

          ${pkgs.findutils}/bin/find /home/${username}/.config/mozilla/firefox -type f -iname "*.${config.home-manager.backupFileExtension}" \
            | ${pkgs.findutils}/bin/xargs -i rm "{}"
        '';
      in
      "${script}";
  };

  virtualisation.docker = {
    enable = true;
    daemon.settings.runtimes.runsc.path = pkgs.lib.getExe' pkgs.gvisor "runsc";
  };

  hardware.nvidia-container-toolkit.enable = true;

  programs = {
    animalese-typing = {
      enable = true;
      layout = "ansi-us";
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${username}/.dotfiles";
    };
  };

  environment.systemPackages = with pkgs; [
    nodejs_24
    pnpm

    vesktop
    spotify-player

    obsidian
    kdePackages.kdenlive

    gparted
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man default.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
