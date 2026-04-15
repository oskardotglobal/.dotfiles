{ system, ... }:
let
  nixpkgsUnstable = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/6201e203d09599479a3b3450ed24fa81537ebc4e.tar.gz";
    sha256 = "sha256-ZojAnPuCdy657PbTq5V0Y+AHKhZAIwSIT2cb8UgAz/U=";
  };

  pkgsUnstable = import nixpkgsUnstable { inherit system; };
in
{
  disabledModules = [ "services/networking/netbird.nix" ];
  imports = [ (nixpkgsUnstable + "/nixos/modules/services/networking/netbird.nix") ];

  services.netbird = {
    enable = true;

    package = pkgsUnstable.netbird;
    ui.package = pkgsUnstable.netbird-ui;
  };
}
