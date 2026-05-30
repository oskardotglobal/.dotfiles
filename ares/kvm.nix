{
  environment.etc."xdg/monitors.xml" = {
    source = ./monitors.xml;
    mode = "0644";
  };

  services = {
    gnome.gnome-remote-desktop = {
      enable = true;
      headless = {
        enable = true;
        username = "oskar";
        passwordFile = "/etc/secrets/rdp_password";
      };
    };

    displayManager = {
      gdm.autoSuspend = false;
      autoLogin.enable = false;
    };

    getty.autologinUser = null;
  };
}
