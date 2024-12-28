{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    element-desktop

    obsidian
    bitwarden
    spotify
    kdePackages.kdenlive

    gparted

    yt-dlp
    qbittorrent
  ];
}
