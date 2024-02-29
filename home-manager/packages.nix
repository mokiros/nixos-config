{ inputs, lib, config, pkgs, ... }:

{
	home.packages = with pkgs; [
		htop
		btop
		neofetch
	];
}
