{ inputs, lib, config, pkgs, ... }:

{
	system.stateVersion = "24.05";
	imports = [
		../configuration_shared.nix
		./hardware-configuration.nix
	];

	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
		};
	};

	networking.hostName = "qemu-nixos";

	services.openssh = {
		enable = true;
		settings = {
			PermitRootLogin = "yes";
			PasswordAuthentication = true;
		};
	};
}

