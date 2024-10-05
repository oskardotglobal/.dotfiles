{pkgs, ...}: {
  imports = [
    ./ssh.nix
    ./syncthing.nix
    ./zsh.nix
    ./winapps.nix

    ./games
    ./nix
    ./work
    ./programming
  ];

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

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
