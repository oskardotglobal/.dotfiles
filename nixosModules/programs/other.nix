{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vesktop
    element-desktop

    obsidian
    zotero
    bitwarden
    spotify
    kdePackages.kdenlive

    gparted

    yt-dlp
    qbittorrent
  ];
}
