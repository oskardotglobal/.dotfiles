{
  flake.homeModules = {
    firefox = ./firefox.nix;
    git = ./git.nix;
    zsh = ./zsh.nix;
    kitty = ./kitty.nix;
    helix = ./helix.nix;
  };
}
