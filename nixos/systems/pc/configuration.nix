{
  ...
}:

{
  networking.hostName = "nixos-pc";
  system.stateVersion = "25.05";

  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix

    # TODO: remove these ugly `../../` patterns
    ../../nix_config.nix
    ../../configuration_common.nix
    ../../grub.nix
    ../../networking.nix
    ../../pipewire.nix
    ../../bash.nix

    ../../packages/common.nix
    ../../packages/flatpak.nix
    ../../packages/kde.nix
    ../../packages/steam.nix

    ../../users/mokiros/user.nix
  ];

  boot.blacklistedKernelModules = [
    "amdgpu"
    "radeon"
  ];

  boot.kernelParams = [
    "radeon.modeset=0"
    "amdgpu.modeset=0"
    "simpledrm=0"
    "nomodeset"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  boot.extraModprobeConfig = ''
    options nvidia-drm modeset=1
  '';
}
