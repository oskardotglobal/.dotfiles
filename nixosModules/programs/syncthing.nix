{ config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "oskar";
    dataDir = "/home/${config.oskardotglobal.home.username}";
  };
}
