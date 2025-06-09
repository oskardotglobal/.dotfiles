{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    lunarvim
    gitFull
    git-blame-someone-else
    just
    unzip
    zip
    ripgrep
    yt-dlp
    file
  ];
}
