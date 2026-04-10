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
        homeModules.helix
        {
          programs = {
            zsh = {
              envExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
              sessionVariables.SSH_AUTH_SOCK = "/Users/${username}/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
            };
            nh = {
              enable = true;
              flake = "/Users/${username}/.dotfiles";
            };
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
    bitwarden-cli
    spotify-player
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [ "netbirdio/tap" ];
    brews = [
      "netbird"
      "mas"
      "cloudflared"
      "libusb" # for ns-usbloader
    ];

    casks = [
      "music-decoy"
      "pearcleaner"

      "signal"
      "deltachat"

      "nextcloud-vfs"
      "obsidian"
      "zotero"
      "calibre"
      "anki"

      "prismlauncher"
      "supertuxkart"

      "intellij-idea"
      "netbird-ui"
    ];

    masApps = {
      # GLKVM = 6740846845;
      Bitwarden = 1352778147;
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
