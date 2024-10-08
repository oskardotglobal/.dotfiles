{...}: {
  networking.hostName = "ares";
  networking.networkmanager.enable = true;

  networking.firewall.enable = false;
}
