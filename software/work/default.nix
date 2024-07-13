{pkgs, ...}: {
  imports = [
    ./netbird.nix
  ];

  environment.systemPackages = with pkgs; [
    vscode

    netbird
    netbird-ui

    brave

    forgejo-runner
  ];
}
