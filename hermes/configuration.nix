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
        homeModules.kitty
        homeModules.git
        homeModules.zsh
        {
          programs.zsh = {
            envExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
            sessionVariables.SSH_AUTH_SOCK = "/Users/${username}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
          };
        }
      ];

      stateVersion = "24.11";
    };
  };

  # TODO: why isn't this set automatically
  system.primaryUser = "oskar";
  users.users.oskar.home = "/Users/oskar";

  environment.systemPackages = with pkgs; [
    rustup

    typst
    tinymist
    # (callPackage ../packages/awrit.nix { })
  ];

  # TODO: Add rquickshare when my PR is merged
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [ "netbirdio/tap" ];
    brews = [
      "netbirdio/tap/netbird"
      "mas"
    ];

    casks = [
      "music-decoy"
      "pearcleaner"

      "zen"
      "ungoogled-chromium"

      "nextcloud-vfs"
      "obsidian"
      "zotero"
      "calibre"

      "jetbrains-toolbox"
      "netbirdio/tap/netbird-ui"

      "orcaslicer"
    ];

    masApps = {
      GLKVM = 6740846845;
      Bitwarden = 1352778147;
      Sushitrain = 6553985316;
    };
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5; # Did you read the changelog?
}
