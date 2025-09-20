{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    netbird
    netbird-ui
  ];

  services.netbird.enable = true;
}
