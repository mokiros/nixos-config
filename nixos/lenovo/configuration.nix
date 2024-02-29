{ inputs, lib, config, pkgs, ... }:

{
	system.stateVersion = "24.05";
	imports = [
		inputs.hardware.nixosModules.common-cpu-intel
		inputs.hardware.nixosModules.common-gpu-intel
		inputs.hardware.nixosModules.common-gpu-nvidia
		inputs.hardware.nixosModules.common-pc-laptop
		inputs.hardware.nixosModules.common-pc-laptop-hdd
		inputs.hardware.nixosModules.common-pc-laptop-ssd
		inputs.hardware.nixosModules.common-pc-laptop-acpi_call
		../configuration_shared.nix
		./hardware-configuration.nix
	];

	boot.loader = {
		efi = {
			canTouchEfiVariables = false;
			efiSysMountPoint = "/boot";
		};
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
		};
	};

	networking.hostName = "lenovo-nixos";

	hardware = {
		opengl.enable = true;
		nvidia.modesetting.enable = true;
	};
}

