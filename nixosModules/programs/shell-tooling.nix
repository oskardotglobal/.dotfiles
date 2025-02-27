{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  environment.systemPackages = with pkgs; [
    lunarvim
    gitFull
    git-blame-someone-else
    just
    pre-commit
    unzip
    zip
    ripgrep
    yt-dlp
  ];
}
