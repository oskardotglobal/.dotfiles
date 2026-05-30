# https://github.com/NixOS/nixpkgs/issues/266774#issuecomment-4401438637
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.gnome.gnome-remote-desktop;

  # Runs as `gnome-remote-desktop` user so full path is:
  # /var/lib/gnome-remote-desktop/.local/share/gnome-remote-desktop/certificates
  stateDir = "/var/lib/gnome-remote-desktop";
  certDir = "${stateDir}/.local/share/gnome-remote-desktop/certificates";
in
{
  options.services.gnome.gnome-remote-desktop.headless = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Whether to unable multi-user headless login.";
    };

    username = lib.mkOption {
      type = lib.types.str;
      default = "rdp";
      description = "Username for RDP connection authentication.";
    };

    passwordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "/etc/nixos/secrets/rdp/password";
      description = ''
        Path to a file containing the RDP connection password. Ensure it is only readable by user `gnome-remote-desktop`.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ 3389 ]; # RDP
      allowedUDPPorts = [ 3389 ]; # RDP
    };

    environment.etc = lib.mkIf cfg.headless.enable {
      "gnome-remote-desktop/grd.conf".text = ''
        [RDP]
        tls-key=${certDir}/rdp-tls.key
        tls-cert=${certDir}/rdp-tls.crt
        enabled=true
      '';
    };

    systemd.services = {
      # Enable gnome remote desktop via RDP
      # Also enables services.pipewire.enable
      # This doesn't do enough by itself though
      # See https://github.com/NixOS/nixpkgs/issues/266774
      "gnome-remote-desktop" = {
        wantedBy = [ "graphical.target" ];
        # Restarts the main service whenever headless mode is enabled/disabled so that
        # changes to the grd.conf are picked up.
        restartTriggers = [ "headless-enabled: ${builtins.toString cfg.headless.enable}" ];
      };

      # New service to ensure certificates and credentials
      "gnome-remote-desktop-setup" = lib.mkIf cfg.headless.enable {
        description = "Initialize GNOME Remote Desktop certificates and credentials";

        # Tie this service to the main one
        before = [ "gnome-remote-desktop.service" ];
        wantedBy = [ "gnome-remote-desktop.service" ];
        partOf = [ "gnome-remote-desktop.service" ];

        serviceConfig = {
          Type = "oneshot";
          User = "gnome-remote-desktop";
          Group = "gnome-remote-desktop";
          StateDirectory = "gnome-remote-desktop";
          LoadCredential = "rdp_pass:${cfg.headless.passwordFile}";
        };

        path = with pkgs; [
          freerdp
          gnome-remote-desktop
        ];

        script = ''
          # Generate certs if missing
          # TODO: How are these refreshed upon expiry?
          if [ ! -f "${certDir}/rdp-tls.key" ]; then
            winpr-makecert -silent -rdp -path "${certDir}" rdp-tls
            # Certs only readable by gnome-remote-desktop
            chmod 0600 "${certDir}/rdp-tls.crt" "${certDir}/rdp-tls.key"
          fi

          if [ -f "$CREDENTIALS_DIRECTORY/rdp_pass" ]; then
            grdctl rdp set-credentials "${cfg.headless.username}" < "$CREDENTIALS_DIRECTORY/rdp_pass"
          fi
        '';
      };
    };
  };
}
