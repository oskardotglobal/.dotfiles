{
  environment.etc."xdg/monitors.xml" = {
    source = ./monitors.xml;
    mode = "0644";
  };

  services = {
    /*
      xrdp = {
        enable = true;
        defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
      };
    */

    gnome.gnome-remote-desktop.enable = true;
    displayManager.gdm.autoSuspend = false;

    displayManager.autoLogin.enable = false;
    getty.autologinUser = null;
  };

  systemd.services.gnome-remote-desktop.wantedBy = [ "graphical.target" ];
}
