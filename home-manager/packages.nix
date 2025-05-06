{ inputs, lib, config, pkgs, ... }:

{
	home.packages = with pkgs; [
		btop
		neofetch

		hyprland
		grimblast
		kitty
		wofi
		firefox
		nemo
		hyprlock
		wlogout
		pamixer
		playerctl
		brightnessctl
		waybar
		wl-clipboard
		slurp
		pavucontrol
		networkmanagerapplet
		blueman
		udiskie
	];
}
