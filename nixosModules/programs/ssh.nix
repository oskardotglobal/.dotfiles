{
  services = {
    openssh.enable = true;
    gnome.gcr-ssh-agent.enable = false;
  };

  programs.ssh.startAgent = true;
}
