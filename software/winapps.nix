{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    winapps
    winapps-launcher

    virt-manager
    qemu
    dnsmasq
    iptables
    mdadm

    OVMFFull
  ];

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;

  virtualisation.libvirtd = {
    enable = true;
  };
}
