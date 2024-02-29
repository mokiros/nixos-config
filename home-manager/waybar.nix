{ inputs, lib, config, pkgs, ... }:

{
	programs.waybar.enable = true;
	programs.waybar.settings = {
		layer = "top";

		modules-left = [
			"custom/launcher"
			"cpu"
			"memory"
			"tray"
			"hyprland/workspaces"
		];
		modules-center = [
			"hyprland/window"
		];
		modules-right = [
			"custom/notification"
			"wireplumber"
			"hyprland/language"
			"network"
			"battery"
			"clock"
		];
		
		"custom/launcher" = {
			format = " ";
			on-click = "wofi -i --show drun";
			on-click-right = "killall wofi";
		};

		cpu = {
			interval = 5;
			format = " {}%";
			max-length = 10;
		};

		memory = {
			interval = 5;
			format = " {}%";
			max-length = 10;
		};

		tray = {
			icon-size = 16;
			spacing = 8;
		};

		"hyprland/workspaces" = {};

		"hyprland/window" = {
			format = "{}";
			separate-outputs = true;
		};

		"custom/notification" = {
			tooltip = false;
			format = "{icon}";
			format-icons = {
				notification = "<span foreground='red'><sup></sup></span>";
				none = "";
				dnd-notification = "<span foreground='red'><sup></sup></span>";
				dnd-none = "";
				inhibited-notification = "<span foreground='red'><sup></sup></span>";
				inhibited-none = "";
				dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
				dnd-inhibited-none = "";
			};
			return-type = "json";
			exec-if = "which swaync-client";
			exec = "swaync-client -swb";
			on-click = "swaync-client -t -sw";
			on-click-right = "swaync-client -d -sw";
			escape = true
		};

		wireplumber = {
			tooltip = true;
			scroll-step = 5;
			format = "{icon} {volume}%";
			format-muted = "󰸈";
			on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
			on-click-right = "pavucontrol";
			format-icons = [ "󰕿" "󰖀" "󰕾" "" ];
		};

		"hyprland/language" = {
			format = " {short}";
		};

		network = {
			interval = 10;
			tooltip = true;
			format-wifi = "{icon} {signalStrength}% {essid}";
			format-ethernet = "󰈀 {ifname}";
			format-disconnected = "󰈂";
			format-disabled = "󰀝";
			format-icons = { default = [ "󰤟" "󰤢" "󰤥" "󰤨" ] };
		};

		battery = {
			states = {
				good = 92;
				warning = 40;
				critical = 15;
			};
			format = "{icon}  {capacity}%";
			format-charging = " {capacity}%";
			format-alt = "{time} {icon}";
			format-icons = [ "" "" "" "" "" ];
		};

		clock = {
			format = "{:%H:%M}  ";
			format-alt = "{:%A, %B %d, %Y (%R)}  ";
			tooltip-format = "<tt><small>{calendar}</small></tt>";
			calendar = {
				mode = "year";
				mode-mon-col = 3;
				weeks-pos = "right";
				on-scroll = 1;
				on-click-right = "mode";
				format = {
					months = "<span color='#ffead3'><b>{}</b></span>";
					days = "<span color='#ecc6d9'><b>{}</b></span>";
					weeks = "<span color='#99ffdd'><b>W{}</b></span>";
					weekdays = "<span color='#ffcc66'><b>{}</b></span>";
					today = "<span color='#ff6699'><b><u>{}</u></b></span>";
				};
			};
			actions = {
				on-click-right = "mode";
				on-click-forward = "tz_up";
				on-click-backward = "tz_down";
				on-scroll-up = "shift_up";
				on-scroll-down = "shift_down";
			}
		};
	};
	programs.waybar.style = ./waybar.css;
}
