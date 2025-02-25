{
  inputs,
  homeModules,
  ...
}:
{
  networking.hostName = "Air-von-Oskar";
  nixpkgs.hostPlatform = "aarch64-darwin";

  oskardotglobal = {
    nixpkgs = inputs.nixpkgs-darwin;
    home = {
      username = "oskar";
      displayName = "Oskar Manhart";

      modules = [
        homeModules.alacritty
        homeModules.git
        homeModules.tmux
      ];

      stateVersion = "24.11";
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5; # Did you read the changelog?
}
