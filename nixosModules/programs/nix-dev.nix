{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    statix
    nixd
  ];

  programs.direnv.enable = true;
}
