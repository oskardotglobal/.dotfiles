{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming/8756862665662edad5bbb098d0cba727cde57fec";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, nixpkgs, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} rec {
      systems = ["x86_64-linux" "aarch64-darwin"];

      perSystem = {pkgs, ...}: {
        formatter = pkgs.nixfmt-rfc-style;
      };

      flake = {
        mkModules = with builtins; let
  # Helper function to get unique elements from a list
  unique = list: foldl' (
    acc: elem: if elem acc then acc else acc ++ [elem]
  ) [] list;

  # Recursive merge function
  recursiveMerge =
    attrList:
    let
      mergeAttrsWith =
        attrPath:
        zipAttrsWith (
          n: values:
          if length (tail values) == 0 then
            head values
          else if all isList values then
            unique (concatLists values)
          else if all isAttrs values then
            mergeAttrsWith (attrPath ++ [n]) values
          else
            last values
        );
    in
    mergeAttrsWith [] attrList;

  # Helper function to zip attribute sets with a function
  zipAttrsWith = f: attrSets:
    let
      allAttrs = concatMap attrNames attrSets;
      uniqueAttrs = unique allAttrs;
    in
    listToAttrs (map (name: {
      name = name;
      value = f name (map (attrs: attrs.${name} or null) attrSets);
    }) uniqueAttrs);

          __functor = self: args @ {...}:
            removeAttrs self [ "__functor" ] 
            |> attrValues
            |> map (fn: fn args)
            |> recursiveMerge;
        in
          m: m // {inherit __functor;};

        overlays = {
          spotx = import ./overlays/spotx.nix;
          git-blame-someone-else = import ./overlays/git-blame-someone-else.nix;
        };
      };

      imports = [
        ./nixosModules/flake-module.nix
        ./homeModules/flake-module.nix
        ./darwinModules/flake-module.nix

        ./ares/flake-module.nix
        ./hermes/flake-module.nix
      ];
    };
}
