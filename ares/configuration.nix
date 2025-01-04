{
  pkgs,
  inputs,
  nixosModules,
  homeModules,
  ...
}:
let
  username = "oskar";
in
rec {
  imports = [
    nixosModules.hardware.superdrive
    nixosModules.system
    nixosModules.programs

    nixosModules.nixpkgs
    ./hardware
  ];

  networking.hostName = "ares";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
  };
  home-manager.backupFileExtension = "backup";

  home-manager.users.${username} =
    { ... }:
    {
      imports = [
        homeModules.alacritty
        homeModules.firefox
        homeModules.git
        homeModules.neovim
        homeModules.tmux
      ];

      programs.home-manager.enable = true;
      home.username = username;
      home.homeDirectory = "/home/${username}";

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "24.05";
    };

  systemd.services."home-manager-${username}".serviceConfig.ExecStartPre =
    let
      script = pkgs.writeScript "hm-${username}-pre-start" ''
        #!${pkgs.bash}/bin/bash

        ${pkgs.findutils}/bin/find /home/${username}/.mozilla/firefox -type f -iname "*.${home-manager.backupFileExtension}" \
          | ${pkgs.findutils}/bin/xargs -i rm "{}"
      '';
    in
    "${script}";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man default.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
