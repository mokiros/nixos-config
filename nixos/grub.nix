{
  ...
}:
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      gfxmodeEfi = "auto";
      extraConfig = ''
        insmod gfxterm
        insmod png
        set gfxpayload=keep
        set icondir=($root)/theme/icons
      '';
    };
  };
}
