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

	programs.fish.enable = true;
	programs.starship.enable = true;
	programs.home-manager.enable = true;

	programs.kitty.enable = true;

	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER";
				bind =
			[
				"$mod, F, exec, firefox"
				", Print, exec, grimblast copy area"
			]
			++ (
				# workspaces
				# binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
				builtins.concatLists (builtins.genList (i:
						let ws = i + 1;
						in [
							"$mod, code:1${toString i}, workspace, ${toString ws}"
							"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
						]
					)
					9)
			);
	};

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 1800;
		enableSshSupport = true;
	};
}
