{ ... }:
let
  mkDisk =
    {
      label,
      device,
      fsType,
      neededForBoot ? false,
    }:
    {
      inherit
        label
        device
        fsType
        neededForBoot
        ;

      options = [
        "defaults"
        "x-gvfs-show"
      ];
    };
in
{
  fileSystems."/mnt/largeboi" = mkDisk {
    label = "largeboi";
    device = "/dev/disk/by-uuid/4480c57a-1874-4036-816c-bb6b4b630ea2";
    fsType = "ext4";
  };

  fileSystems."/mnt/fatboi" = mkDisk {
    label = "fatboi";
    device = "/dev/disk/by-uuid/59bd070c-c31e-48bc-8ccd-7bdd1f68fa33";
    fsType = "btrfs";
  };
}
