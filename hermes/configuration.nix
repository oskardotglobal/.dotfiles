{
  darwinModules,
  homeModules,
  ...
}: let
  username = "oskar";
in {
  imports = [
    darwinModules.nixpkgs
  ];

  networking.hostName = "Air-von-Oskar";
  nixpkgs.hostPlatform = "aarch64-darwin";

  /*
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.backupFileExtension = "backup";

  home-manager.users.${username} = {...}: {
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
    home.stateVersion = "24.11";
  };
  */

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5; # Did you read the changelog?
}
