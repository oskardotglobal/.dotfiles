{pkgs, ...}: {
  imports = [
    ./rust.nix
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    jetbrains-mono

    alacritty

    jetbrains.jdk
    jetbrains.rust-rover
    jetbrains.phpstorm
    jetbrains.idea-ultimate

    neovim
    zed-editor

    gitFull
    just
    zoxide
    pre-commit
    unzip
    zip

    jdk21
    bun
    nodejs_20
    nodePackages.pnpm
  ];
}
