{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode

    netbird
    netbird-ui
  ];

  services.netbird.enable = true;
}
