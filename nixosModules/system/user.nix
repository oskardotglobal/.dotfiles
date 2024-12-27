{pkgs, ...}: {
  users.users.oskar = {
    isNormalUser = true;
    description = "Oskar Manhart";
    extraGroups = ["networkmanager" "wheel" "docker" "kvm" "libvirtd"];
    shell = pkgs.zsh;
  };
}
