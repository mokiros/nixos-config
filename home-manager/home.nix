{ inputs, lib, config, pkgs, ... }:

{
	home.stateVersion = "24.05";
	imports = [
		./packages.nix
	];

	home.username = "mokiros";
	home.homeDirectory = "/home/mokiros";

	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "${pkgs.micro}/bin/micro";
	};

	programs.zsh.enable = true;
	programs.starship.enable = true;
	programs.home-manager.enable = true;

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 1800;
		enableSshSupport = true;
	};
}
