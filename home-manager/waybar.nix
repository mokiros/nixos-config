{}:

{
	programs.waybar = {
		enable = true;
		style = builtins.readFile ./waybar.css;
		settings = [{
			height = 30;
			spacing = 4;
			modules-left = [
				"hyprland/workspaces"
				"hyprland/submap"
				"custom/media"
			];
			modules-center = [
				"hyprland/window"
			];
			modules-right = [
				"mpd"
				"idle_inhibitor"
				"wireplumber"
				"network"
				"power-profiles-daemon"
				"cpu"
				"memory"
				"temperature"
				"backlight"
				"keyboard-state"
				"battery"
				"clock"
				"tray"
				"custom/power"
			];
		}];
	}
}
