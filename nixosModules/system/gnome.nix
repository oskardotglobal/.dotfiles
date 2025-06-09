{
  pkgs,
  config,
  ...
}:
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services = {
    xserver = {
      enable = true;

      xkb = {
        layout = "de";
        variant = "nodeadkeys";
      };

      videoDrivers = [ "nvidia" ];

      displayManager.gdm = {
        enable = true;
        wayland = false;
      };

      desktopManager.gnome.enable = true;
    };

    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse = {
        accelProfile = "flat";
      };
    };

    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    gnome-console

    cheese # webcam tool
    gnome-music
    gnome-terminal
    epiphany # web browser
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ];

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
}
