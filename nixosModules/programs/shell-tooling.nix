{ pkgs, inputs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    inputs.self.packages."${pkgs.system}".helix
    gitFull
    just
    unzip
    zip
    ripgrep
    yt-dlp
    file
    gnused
  ];
}
