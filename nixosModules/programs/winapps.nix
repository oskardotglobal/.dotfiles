{
  inputs,
  system,
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inputs.winapps.packages."${system}".winapps
    inputs.winapps.packages."${system}".winapps-launcher

    virt-manager
    qemu
    dnsmasq
    iptables
    mdadm
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users."${config.oskardotglobal.home.username}".extraGroups = [
    "kvm"
    "libvirtd"
  ];
}
