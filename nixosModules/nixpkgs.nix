{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.oskardotglobal.nixpkgs = lib.mkOption {
    type = lib.types.anything;
    default = inputs.nixpkgs;
    description = "The nixpkgs input to use. Defaults to `inputs.nixpkgs`";
  };

  config = {
    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # "broadcom-sta-6.30.223.271-57-6.12.45"
      ];
    };

    nix = {
      package = pkgs.lixPackageSets.stable.lix;

      # make `nix run nixpkgs#package` use the same nixpkgs as the one used by this flake.
      registry.nixpkgs.flake = config.oskardotglobal.nixpkgs;

      # remove nix-channel related tools & configs, we use flakes instead.
      channel.enable = false;

      # Keep nixPath so we don't have to use flakes for dev shells
      nixPath = lib.mkDefault [ "nixpkgs=${config.oskardotglobal.nixpkgs}" ];

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operator"
        ];

        trusted-users = [ "@wheel" ];

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
  };
}
