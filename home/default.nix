{...}: {
  imports = [
    ./git.nix
    ./firefox.nix
    ./nvim.nix
    ./tmux.nix
  ];

  programs.home-manager.enable = true;
  home.username = "oskar";
  home.homeDirectory = "/home/oskar";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";
}
