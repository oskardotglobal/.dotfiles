{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    gitFull
    just
    unzip
    zip
    ripgrep
    yt-dlp
    file
    gnused
    presenterm
    tree
    tokei
    wget
  ];
}
