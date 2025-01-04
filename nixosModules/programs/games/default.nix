{
  pkgs,
  nix-gaming,
  nix-citizen,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wine
    gamemode
    lutris

    ryujinx

    prismlauncher

    path-of-building

    nix-gaming.packages.${system}.osu-lazer-bin

    nix-citizen.packages.${system}.star-citizen-helper
    nix-citizen.packages.${system}.lug-helper
  ];
}
