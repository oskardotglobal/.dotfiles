{...}: {
  services.syncthing = {
    enable = true;
    user = "oskar";
    dataDir = "/home/oskar";
  };
}
