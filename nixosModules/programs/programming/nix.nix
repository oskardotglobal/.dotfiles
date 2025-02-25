{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alejandra
    nixfmt-rfc-style
    statix
    nixd
    devenv
  ];
}
