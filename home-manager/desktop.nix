{ config, pkgs, ... }:

{
	imports = [
		./hyprland.nix
	];

	xdg.portal = {
		enable = true;
		wlr.enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-wlr
			xdg-desktop-portal-gtk
		];
	};

	programs.dunst = {
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
