{
  inputs,
  darwinModules,
  homeModules,
  ...
}:
let
  username = "oskar";
in
{
  imports = [
    darwinModules.nixpkgs
    darwinModules.programming
    darwinModules.macos
  ];

  networking.hostName = "Air-von-Oskar";
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = "backup";

    users.${username} = _: {
      imports = [
        homeModules.alacritty
        homeModules.git
        homeModules.tmux
      ];

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      #
      # You can update Home Manager without changing this value. See
      # the Home Manager release notes for a list of state version
      # changes in each release.
      home.stateVersion = "24.11";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5; # Did you read the changelog?
}
