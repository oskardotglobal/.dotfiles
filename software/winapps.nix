{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    winapps
    winapps-launcher

    virt-manager
    qemu
    dnsmasq
    iptables
    mdadm
  ];

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;

  systemd.services.virtual-disk-md0 = {
    enable = true;
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = "/home/oskar/.dotfiles/vm/start_md0";
      ExecStop = "/home/oskar/.dotfiles/vm/stop_md0";
    };

    wantedBy = ["multi-user.target"];
  };

  virtualisation.libvirtd = {
    enable = true;
  };
}
