{ config, pkgs, ... }:
let
	startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
		# ${pkgs.waybar}/bin/waybar &
		# ${pkgs.swww}/bin/swww init &
		# sleep 1
		# ${pkgs.swww}/bin/swww img wallpaper.png &
	'';
in
{
	wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.xwayland.enable = true;
	wayland.windowManager.hyprland.settings = {
		"$terminal" = "${pkgs.kitty}/bin/kitty";

		exec-once = ''${startupScript}/bin/start'';

		monitor = [
			"eDP-1,preferred,1920x0,1"
			"HDMI-A-1,preferred,0x0,1"
		];
		workspace = [
			"1, persistent:true, default:true, monitor:eDP-1"
			"2, monitor:eDP-1"
			"3, monitor:eDP-1"
			"4, monitor:eDP-1"
			"5, persistent:true, default:true, border:false, gapsout:0, bordersize:0, monitor:HDMI-A-1"
			"6, monitor:HDMI-A-1"
			"7, monitor:HDMI-A-1"
			"8, monitor:HDMI-A-1"
		];

		input = {
			kb_layout = "us, ru";
			kb_variant = "";
			kb_model = "";
			kb_options = "grp:win_space_toggle";
			kb_rules = "";
			follow_mouse = "1";
			touchpad = {
				disable_while_typing = false;
				natural_scroll = true;
			};
			sensitivity = -0.7;
		};

		"device:synps/2-synaptics-touchpad" = {
			sensitivity = 0.5;
		};

		general = {
			gaps_in = 2;
			gaps_out = 2;
			border_size = 1;
			"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
			"col.inactive_border" = "rgba(595959aa)";
			layout = "dwindle";
			allow_tearing = false;
		};

		decoration = {
			rounding = 4;
			blur = {
				enabled = true;
				size = 3;
				passes = 2;
				vibrancy = 0.1696;
			};
			drop_shadow = true;
			shadow_range = 4;
			shadow_render_power = 3;
			"col.shadow" = "rgba(1a1a1aee)";
		};

		group = {
			groupbar = {
				height = 10;
				text_color = "0xffffffff";
				col.active = "0x66ffff00";
				col.inactive = "0x66777700";
				col.locked_active = "0x66ff5500";
				col.locked_inactive = "0x66775500";
			};
		};

		animations = {
			enabled = true;
			bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
			animation = [
				"windows, 1, 3, myBezier"
				"windowsOut, 1, 3, default, popin 80%"
				"border, 1, 10, default"
				"borderangle, 1, 5, default"
				"fade, 1, 1, default"
				"workspaces, 1, 1, default"
			];
		};

		dwindle = {
			pseudotile = true;
			preserve_split = true;
		};

		master = {
			new_is_master = true;
		};

		gestures = {
			workspace_swipe = false;
		};

		windowrulev2 = "nomaximizerequest, class:.*";

		"$mainMod" = "SUPER";
		bindm = [
			"$mainMod, mouse:272, movewindow"
			"$mainMod, mouse:273, resizewindow"
		];
		bind =
			[
				"$mainMod, E, exec, $fileManager"
				"$mainMod SHIFT, V, togglefloating,"
				"$mainMod, left, movefocus, l"
				"$mainMod, right, movefocus, r"
				"$mainMod, up, movefocus, u"
				"$mainMod, down, movefocus, d"
				"$mainMod, O, togglespecialworkspace, magic"
				"$mainMod SHIFT, O, movetoworkspace, special:magic"
				# "$mainMod, R, exec, $menu"
			]
			++ (
				# workspace binds
				builtins.concatLists(builtins.genList(
					x: let
						ws = let
							c = (x + 1) / 10;
						in
							builtins.toString(x+1-(c*10));
						in [
							"$mainMod, ${ws}, workspace, ${toString(x+1)}"
							"$mainMod SHIFT, ${ws}, movetoworkspace, ${toString(x+1)}"
						]
				) 10)
			);
	};
}
