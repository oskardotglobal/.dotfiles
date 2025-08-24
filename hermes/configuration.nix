{
  pkgs,
  inputs,
  homeModules,
  ...
}:
{
  networking.hostName = "Air-von-Oskar";
  nixpkgs.hostPlatform = "aarch64-darwin";

  oskardotglobal = {
    nixpkgs = inputs.nixpkgs-darwin;
    home = rec {
      username = "oskar";
      displayName = "Oskar Manhart";

      modules = [
        homeModules.alacritty
        homeModules.git
        homeModules.tmux
        homeModules.zsh
      ];

      stateVersion = "24.11";
    };
  };

  users.users.oskar.home = "/Users/oskar";

  environment.systemPackages = with pkgs; [
    rustup
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5; # Did you read the changelog?
}
