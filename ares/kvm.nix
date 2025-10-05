{ pkgs, lib, ... }:
let
  dest = "/home/oskar/.config/monitors.xml";
in
{
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - root - - ${dest}"
    "C+ ${dest} - oskar - - ${./monitors.xml}"
  ];

  services = {
    xrdp = {
      enable = true;
      defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
      /*
        pkgs.writeShellScriptBin "xrdp-xstartup" ''
          # cp -f ${./monitors-kvm.xml} ${dest}
          # chown oskar ${dest}

          ${pkgs.gnome-session}/bin/gnome-session "$@"
        ''
        |> lib.getExe;
      */
    };

    gnome.gnome-remote-desktop.enable = true;
    xserver.displayManager.gdm.autoSuspend = false;

    displayManager.autoLogin.enable = false;
    getty.autologinUser = null;
  };
}
