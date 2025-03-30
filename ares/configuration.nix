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
  ];

  nixpkgs.overlays = [
    inputs.nur.overlays.default

    self.overlays.spotx
    self.overlays.git-blame-someone-else
  ];

  networking.hostName = "ares";

  oskardotglobal.home = {
    username = "oskar";
    displayName = "Oskar Manhart";

    modules = [
      { home.homeDirectory = "/home/${username}"; }

      homeModules.alacritty
      homeModules.firefox
      homeModules.git
      homeModules.tmux
      homeModules.rustdesk
      homeModules.zsh
    ];

    stateVersion = "24.05";
  };

  systemd.services."home-manager-${username}".serviceConfig.ExecStartPre =
    let
      script = pkgs.writeScript "hm-${username}-pre-start" ''
        #!${pkgs.bash}/bin/bash

        ${pkgs.findutils}/bin/find /home/${username}/.mozilla/firefox -type f -iname "*.${config.home-manager.backupFileExtension}" \
          | ${pkgs.findutils}/bin/xargs -i rm "{}"
      '';
    in
    "${script}";

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "kvm"
      "libvirtd"
    ];
  };

  virtualisation.docker.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/${username}/.dotfiles";
  };

  environment.systemPackages = with pkgs; [
    jetbrains.jdk
    jetbrains.idea-ultimate
    zed-editor

    jdk21
    bun
    nodejs_20
    nodePackages.pnpm

    vesktop
    element-desktop

    obsidian
    zotero
    bitwarden
    spotify
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
