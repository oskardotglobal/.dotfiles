{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vscode

    netbird
    netbird-ui

    brave

    forgejo-runner
  ];

  services.netbird.enable = true;
}
