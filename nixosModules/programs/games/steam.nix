{pkgs, ...}: {
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    extraCompatPackages = with pkgs; [proton-ge-bin];
    extraPackages = with pkgs; [gamescope];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.gamemode.enable = true;
}
