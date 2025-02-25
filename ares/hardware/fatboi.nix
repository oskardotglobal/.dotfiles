{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  # TODO: the disk is still not writable
  fileSystems."/run/media/oskar/fatboi" = {
    label = "fatboi";
    device = "/dev/sda2";
    fsType = "ntfs-3g";
    options = [
      "nofail"
      "exec"
      "uid=1000"
      "gid=100"
      "dmask=007"
      "fmask=117"
      "user"
      "u+rwx"
      "g+rwx"
      "o+rwx"
      "rw"
    ];
  };
}
