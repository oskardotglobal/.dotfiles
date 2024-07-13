{pkgs, ...}: {
  users.users.oskar = {
    isNormalUser = true;
    description = "Oskar Manhart";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };
}
