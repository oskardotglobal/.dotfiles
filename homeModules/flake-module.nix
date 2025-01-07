_:
{
  flake.homeModules = {
    alacritty = ./alacritty.nix;
    firefox = ./firefox.nix;
    git = ./git.nix;
    neovim = ./nvim.nix;
    tmux = ./tmux.nix;
  };
}
