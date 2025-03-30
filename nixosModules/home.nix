{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.oskardotglobal.home;
  isDarwin = config.nixpkgs.hostPlatform == "aarch64-darwin";
in
{
  options.oskardotglobal.home =
    with lib;
    mkOption {
      description = "Basic home-manager setup";
      type = types.submodule {
        options = {
          username = mkOption {
            type = types.str;
            description = "The username of the user managed by home-manager.";
            default = "oskar";
          };

          displayName = mkOption {
            type = types.str;
            description = "The display name of the user managed by home-manager.";
            default = "Oskar Manhart";
          };

          stateVersion = mkOption {
            type = types.str;
            description = ''
              This value determines the Home Manager release that your
              configuration is compatible with. This helps avoid breakage
              when a new Home Manager release introduces backwards
              incompatible changes.

              You can update Home Manager without changing this value. See
              the Home Manager release notes for a list of state version
              changes in each release.
            '';
          };

          modules = mkOption {
            type = types.listOf types.anything;
            description = "A list of home-manager modules to import.";
            default = [ ];
          };
        };
      };
    };

  config = {
    programs.zsh.enable = true;

    users.users."${cfg.username}" = {
      name = cfg.username;
      description = "Oskar Manhart";
      shell = pkgs.zsh;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
      };
      backupFileExtension = "backup";

      users."${cfg.username}" = {
        imports = cfg.modules;
        home = {
          inherit (cfg) stateVersion;
          homeDirectory = lib.mkIf isDarwin /Users/${cfg.username};
        };
      };
    };
  };
}
