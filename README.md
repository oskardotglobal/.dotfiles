# Oskar's dotfiles

## Spotx-Bash overlay

### Usage with flakes

Simply add this repo as an input and use the overlay `spotx` it outputs like:

```nix
{
  description = "My configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    oskars-dotfiles = {
      url = "github:oskardotglobal/.dotfiles/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    oskars-dotfiles,
    ...
  }: {
    nixosConfigurations.
      hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      modules = [
        ./configuration.nix
        ({pkgs, ...}: {
          nixpkgs.overlays = [oskars-dotfiles.overlays.spotx];
          environment.systemPackages = [pkgs.spotify];
        })
      ];
    };
  };
}
```

### Usage without flakes

Even though flakes are recommended, this will work without flakes too.  
In your `configuration.nix`

```nix 
{pkgs, ...}: {
  nixpkgs.overlays = [import (builtins.fetchTarball "https://github.com/oskardotglobal/.dotfiles/archive/nix.tar.gz")];
  environment.systemPackages = [pkgs.spotify];
}
```
