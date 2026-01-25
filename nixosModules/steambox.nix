{ config, ... }:
{
  boot.extraModulePackages = with config.boot.kernelPackages; [ xone ];

  specialisation.steambox.configuration = {
    systemd.user.services.steam = {
      enable = true;
      description = "Open Steam Big Picture at boot";
      serviceConfig = {
        ExecStart = "xdg-open steam://open/bigpicture";
        wantedBy = [ "graphical-session.target" ];
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}
