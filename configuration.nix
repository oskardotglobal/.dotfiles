{
  pkgs,
  inputs,
  ...
}: let
  username = "oskar";
in rec {
  imports = [
    ./hardware
    ./system
    ./software
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.backupFileExtension = "backup";

  home-manager.users."${username}" = import ./home;

  systemd.services."home-manager-${username}".serviceConfig.ExecStartPre = let
    script = pkgs.writeScript "hm-${username}-pre-start" ''
      #!${pkgs.bash}/bin/bash

      ${pkgs.findutils}/bin/find /home/${username}/.mozilla/firefox/0 -type f -iname "*.${home-manager.backupFileExtension}" \
        | ${pkgs.findutils}/bin/xargs -i rm "{}"
    '';
  in "${script}";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man default.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
