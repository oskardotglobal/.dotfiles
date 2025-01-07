_: {
  flake.darwinModules = {
    nixpkgs = ./nixpkgs.nix;
    programming = ./programming.nix;
    macos = ./macos.nix;
  };
}
