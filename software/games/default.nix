{
  pkgs,
  nix-gaming,
  nix-citizen,
  ...
}: {
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    gamemode
    nix-gaming.packages.${system}.osu-lazer-bin
    nix-citizen.packages.${system}.star-citizen
    nix-citizen.packages.${system}.star-citizen-helper
    nix-citizen.packages.${system}.lug-helper

    wine
    lutris
    prismlauncher
  ];
}
