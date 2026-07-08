{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-tree
    nixfmt

    statix
    nixd
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
