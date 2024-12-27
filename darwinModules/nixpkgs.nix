{
  inputs,
  lib,
  ...
}: {
  nix = {
    # remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;

    # Keep nixPath so we don't have to use flakes for dev shells
    nixPath = ["nixpkgs=${inputs.nixpkgs-darwin}"];

    settings = {
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
      trusted-users = ["@wheel"];

      substituters = [
        "https://nix-gaming.cachix.org"
        "https://nix-citizen.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
