{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./l10n.nix
    ./gnome.nix
    ./cups.nix
    ./sound.nix
    ./user.nix
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://nix-gaming.cachix.org" "https://nix-citizen.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
    trusted-users = ["oskar"];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];
}
