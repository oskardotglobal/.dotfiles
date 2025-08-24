{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    lunarvim
    gitFull
    just
    unzip
    zip
    ripgrep
    yt-dlp
    file
  ];
}
