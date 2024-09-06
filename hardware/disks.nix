{...}: {
  fileSystems."/run/media/oskar/michealsoft-binbows" = {
    label = "michealsoft-binbows";
    device = "/dev/nvme0n1p3";
    fsType = "ntfs";
    options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  };

  fileSystems."/run/media/oskar/fatboi" = {
    label = "fatboi";
    device = "/dev/sda2";
    fsType = "ntfs";
    options = ["nofail" "uid=1000" "gid=100" "dmask=007" "fmask=117" "user" "u+rwx" "g+rwx" "o+rwx"];
  };
}
