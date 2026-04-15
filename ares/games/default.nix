{
  pkgs,
  nix-gaming,
  nix-citizen,
  ...
}:
{
  imports = [ ./steam.nix ];

  programs.ns-usbloader.enable = true;

  environment.systemPackages = with pkgs; [
    lutris

    obs-studio

    prismlauncher
    ryubing

    # nix-gaming.packages.${system}.osu-lazer-bin
    # nix-citizen.packages.${system}.rsi-launcher
  ];

  # https://wiki.starcitizen-lug.org/Performance-Tuning#zram--swap

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
    memoryMax = 32 * 1024 * 1024 * 1024;
  };
}
