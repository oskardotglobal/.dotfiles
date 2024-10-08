{
  pkgs,
  pkgs-unstable,
  nix-gaming,
  nix-citizen,
  ...
}: {
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    wine
    gamemode
    lutris
    protonup-qt

    ryujinx

    prismlauncher

    pkgs-unstable.path-of-building

    nix-gaming.packages.${system}.osu-lazer-bin

    nix-citizen.packages.${system}.star-citizen-helper
    nix-citizen.packages.${system}.lug-helper
  ];
}
