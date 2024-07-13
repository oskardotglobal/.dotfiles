#!/bin/bash

set -eux

curl -sSL https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-24.05/pkgs/applications/audio/spotify/default.nix > default.nix
curl -sSL https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-24.05/pkgs/applications/audio/spotify/linux.nix > linux.nix

alejandra -q .
patch linux.nix linux.nix.patch

