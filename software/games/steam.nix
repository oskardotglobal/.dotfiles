{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    extraCompatPackages = with pkgs-unstable; [proton-ge-bin];
    extraPackages = with pkgs; [gamescope];
  };

  programs.gamemode.enable = true;
}
