{
  pkgs,
  ...
}:
{
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;
  };

  services = {
    xserver = {
      enable = true;

      xkb = {
        options = "caps:escape";
        layout = "us";
        variant = "altgr-intl";
      };

      videoDrivers = [ "nvidia" ];
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    libinput = {
      enable = true;

      # disabling mouse acceleration
      mouse.accelProfile = "flat";
    };

    gnome = {
      core-apps.enable = false;
      core-developer-tools.enable = false;
      games.enable = false;
    };

    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";

    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];

    systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      gnome-randr

      gnome-text-editor
      gnome-calculator
      gnome-calendar
      gnome-contacts

      nautilus # file manager
      loupe # image viewer
      evince # document viewer
      baobab # disk usage
      seahorse # gnome keyring
      sushi # nautilus quick preview
      geary # email

      mpv
      btop-cuda
    ];
  };
}
