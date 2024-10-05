{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # ./rust.nix
    ./docker.nix
  ];

  environment.systemPackages = with pkgs; [
    jetbrains-mono

    alacritty

    jetbrains.jdk
    jetbrains.rust-rover
    jetbrains.phpstorm
    jetbrains.idea-ultimate

    android-studio

    neovim
    pkgs-unstable.zed-editor

    gitFull
    just
    zoxide
    pre-commit
    unzip
    zip
    ripgrep
    wakatime

    jdk21
    bun
    nodejs_20
    nodePackages.pnpm
  ];
}
