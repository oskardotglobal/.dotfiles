_: {
  flake.darwinModules = {
    nixpkgs = ./nixpkgs.nix;
    programming = ./programming.nix;
    goldwarden = ./goldwarden.nix;
    macos = ./macos.nix;
  };
}
