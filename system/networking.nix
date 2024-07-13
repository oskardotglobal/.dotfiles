{...}: {
  networking.hostName = "ares";
  networking.extraHosts = "127.0.0.1 modules-cdn.eac-prod.on.epicgames.com";
  networking.networkmanager.enable = true;

  networking.firewall.enable = false;
}
