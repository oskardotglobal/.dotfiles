{
  pkgs,
  config,
  ...
}: let
  theme = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "firefox-gnome-theme";
    version = "129";

    src = pkgs.fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "${pname}";
      rev = "v${version}";
      hash = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM=";
    };

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out
      cp -r ./* $out/
    '';

    meta = with pkgs.lib; {
      description = "A GNOME theme for Firefox";
      homepage = "https://github.com/rafaelmardojai/firefox-gnome-theme";
      license = licenses.unlicense;
      platforms = platforms.all;
    };
  };
  /*
    pkgs.stdenv.mkDerivation {
    name = "arcwtf";
    src = pkgs.fetchgit {
      url = "https://github.com/KiKaraage/ArcWTF";
      rev = "885fa7d5e730e3937e3a8b7e966a36ff2421c744";
      hash = "sha256-QUsb9XsP3VT0wFCUJGMHkF/AtgCYt5xIdvkLvqg90Xs=";
    };

    installPhase = ''
      cp -v -r $src $out/
    '';
  };
  */
in {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  home.file."/.mozilla/firefox/0/chrome" = {
    enable = true;
    source = theme;
    recursive = true;
  };

  programs.firefox.profiles."dev-edition-default" = {
    id = 0;

    search = {
      default = "Oskar's 4get";

      engines = {
        "NixOS Packages" = {
          urls = [{template = "https://search.nixos.org/packages?query={searchTerms}";}];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@pkgs"];
        };

        "NixOS Options" = {
          urls = [{template = "https://search.nixos.org/options?query={searchTerms}";}];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@opts"];
        };

        "Oskar's 4get".urls = [{template = "https://search.oskar.global/web?s={searchTerms}";}];
      };
    };

    settings = {
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;

      "uc.tweak.popup-search" = true;
      "uc.tweak.longer-sidebar" = true;

      # Disable password manager
      "signon.rememberSignons" = false;

      # Automatically enable installed extensions
      "extensions.autoDisableScopes" = 0;
    };

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      # sidebery
      # userchrome-toggle

      ublock-origin
      bitwarden
    ];
  };
}
