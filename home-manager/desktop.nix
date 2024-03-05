{ config, pkgs, ... }:

{
	imports = [
		./hyprland.nix
		./i3.nix
		./awesomewm.nix
	];

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-wlr
			xdg-desktop-portal-gtk
		];
	};

	services.dunst = {
		enable = true;
	};

	programs.kitty = {
		enable = true;
	};

	programs.rofi = {
		enable = true;
	};

	programs.firefox = {
		enable = true;
	};
}
