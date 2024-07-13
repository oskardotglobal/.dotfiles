{pkgs, ...}: {
  imports = [
    ./nh.nix
    ./direnv.nix
  ];

  environment.systemPackages = with pkgs; [
    alejandra
    nil
  ];
}
