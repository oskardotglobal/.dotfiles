{
  pkgs,
  nix-gaming,
  ...
}:
{
  imports = [ ./steam.nix ];

  environment.systemPackages = with pkgs; [
    lutris

    obs-studio

    prismlauncher
    ryujinx
    nix-gaming.packages.${system}.osu-lazer-bin
  ];

  programs.ns-usbloader.enable = true;
}
