{
  pkgs,
  nix-gaming,
  nix-citizen,
  ...
}:
{
  imports = [ ./steam.nix ];

  environment.systemPackages = with pkgs; [
    wine
    gamemode
    lutris

    ryujinx
    obs-studio

    prismlauncher

    path-of-building

    nix-gaming.packages.${system}.osu-lazer-bin

    nix-citizen.packages.${system}.star-citizen-helper
    nix-citizen.packages.${system}.lug-helper
  ];

  programs.ns-usbloader.enable = true;
}
