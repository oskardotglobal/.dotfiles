{ pkgs, ... }:
{
  home.packages = [ pkgs.rustdesk-flutter ];

  xdg.configFile."autostart/rustdesk.desktop" = {
    source =
      let
        name = "rustdesk-service";
        desktopFile = pkgs.makeDesktopItem {
          inherit name;
          desktopName = "RustDesk Service";
          exec = "rustdesk --service %u";
          terminal = false;
          startupNotify = true;
          extraConfig = {
            "X-GNOME-Autostart-enabled" = "true";
            Hidden = "true";
          };
        };
      in
      "${desktopFile}/share/applications/${name}.desktop";
    executable = true;
  };
}
