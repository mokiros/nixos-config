{
  ...
}:

{
  time.timeZone = "Europe/Minsk";
  i18n.defaultLocale = "en_IE.UTF-8";

  boot.supportedFilesystems = [
    "btrfs"
    "ext4"
    "fat32"
    "exfat"
  ];

  services.rpcbind.enable = true;

  security.polkit.enable = true;
}
