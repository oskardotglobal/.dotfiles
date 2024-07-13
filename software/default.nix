{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./ssh.nix
    ./syncthing.nix
    ./zsh.nix
    ./firefox.nix

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
    pkgs-unstable.freerdp3
  ];
}
