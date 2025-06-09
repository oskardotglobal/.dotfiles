let
  mkDisk =
    {
      device,
      fsType,
      neededForBoot ? false,
    }:
    {
      inherit
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
    device = "/dev/disk/by-uuid/4480c57a-1874-4036-816c-bb6b4b630ea2";
    fsType = "ext4";
  };

  fileSystems."/mnt/fatboi" = mkDisk {
    device = "/dev/disk/by-uuid/59bd070c-c31e-48bc-8ccd-7bdd1f68fa33";
    fsType = "btrfs";
  };
}
