{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-tree
    nixfmt-rfc-style

    statix
    nixd
    devenv
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
