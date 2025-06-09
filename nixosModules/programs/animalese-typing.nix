{
  lib,
  pkgs,
  config,
  ...
}:
let
  package = pkgs.callPackage (
    {
      lib,
      fetchFromGitHub,
      rustPlatform,
      nix-update-script,
      versionCheckHook,
      xorg,
      alsa-lib-with-plugins,
      pkg-config,
      llvmPackages,
      mold-wrapped,
    }:
    rustPlatform.buildRustPackage rec {
      pname = "animalese-typing";
      version = "0.1.1";

      src = fetchFromGitHub {
        owner = "oskardotglobal";
        repo = "animalese-typing-rs";
        tag = "v${version}";
        hash = "sha256-qErkyzsWZh5sL8ATD5hnys0Ve6LcxgqFU2ICa0qFNcg=";
      };

      postUnpack = ''
        mkdir -p $out
        cp -r $src/assets/ $out/
      '';

      env.RUSTC_BOOTSTRAP = 1;

      nativeBuildInputs = [
        mold-wrapped
        pkg-config
        llvmPackages.libcxxClang
      ];

      buildInputs = [
        xorg.libX11
        alsa-lib-with-plugins
      ];

      useFetchCargoVendor = true;
      cargoHash = "sha256-0p2Ejhd9jTM8YbnznkRz8UoEcUzpj9IphzHK3kEIZb4=";

      nativeInstallCheckInputs = [ versionCheckHook ];
      versionCheckProgramArg = "--version";
      doInstallCheck = true;

      passthru.updateScript = nix-update-script { };

      meta = {
        description = "Play Animal crossing sounds when you type";
        homepage = "https://github.com/oskardotglobal/animalese-typing-rs";
        changelog = "https://github.com/oskardotglobal/animalese-typing-rs/releases/tag/v${version}";
        mainProgram = "animalese-typing";
        license = lib.licenses.gpl3Only;
        maintainers = with lib.maintainers; [ oskardotglobal ];
      };
    }
  ) { };
  cfg = config.programs.animalese-typing;
in
{
  meta.maintainers = with lib.maintainers; [ oskardotglobal ];

  options.programs.animalese-typing = {
    enable = lib.mkEnableOption "animalese-typing, play Animal crossing sounds when you type";

    voice = lib.mkOption {
      type = lib.types.int;
      default = 1;
      description = "Voice to use (1-8), where 1-4 are 'female' and 5-8 are 'male'";
    };

    layout = lib.mkOption {
      type = lib.types.enum [
        "ansi-us"
        "iso-de"
      ];
      default = "ansi-us";
      description = "The keyboard layout to use.";
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.voice >= 1 && cfg.voice <= 8;
        message = "animalese-typing.voice has to be between 1 and 8";
      }
    ];

    systemd.user.services.animalese-typing = lib.mkIf cfg.enable {
      enable = true;
      description = "animalese-typing";

      partOf = [
        "sound.target"
        "graphical-session.target"
      ];

      after = [
        "sound.target"
        "graphical-session.target"
      ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe package} --voice ${builtins.toString cfg.voice} --layout ${cfg.layout}";
        WorkingDirectory = "${package}";
      };
    };
  };
}
