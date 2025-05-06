{ inputs, lib, config, pkgs, ... }:

{
	home.packages = with pkgs; [
		btop
		neofetch

		grimblast
	];
}
