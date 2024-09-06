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

  environment.systemPackages = with pkgs; [
    vesktop
    element-desktop

    obsidian
    bitwarden
    spotify
    kdePackages.kdenlive

    gparted

    winapps
    winapps-launcher
  ];
}
