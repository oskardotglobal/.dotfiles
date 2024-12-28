{ self, ... }:
let
  inherit (self) mkModules;
in
{
  flake.homeModules = mkModules {
    alacritty = import ./alacritty.nix;
    firefox = import ./firefox.nix;
    git = import ./git.nix;
    neovim = import ./nvim.nix;
    tmux = import ./tmux.nix;
  };
}
