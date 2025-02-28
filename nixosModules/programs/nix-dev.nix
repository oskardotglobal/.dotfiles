{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    statix
    nixd
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
