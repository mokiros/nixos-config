{ inputs, lib, config, pkgs, ... }:

let
  # Define common programs using pkgs
  terminal = "${pkgs.kitty}/bin/kitty"; # Make sure this is defined!
  browser = "${pkgs.firefox}/bin/firefox";
  fileManager = "${pkgs.nemo}/bin/nemo"; # Or pkgs.thunar, pkgs.dolphin, pkgs.pcmanfm
  launcher = "${pkgs.wofi}/bin/wofi --show drun"; # A common dmenu/rofi alternative for Wayland
  locker = "${pkgs.hyprlock}/bin/hyprlock"; # Hyprland's native locker
  # Simple power menu using wlogout (needs configuration separately, see explanation)
  powerMenu = "${pkgs.wlogout}/bin/wlogout -P layer-shell"; # Or a custom script

  # System control commands
  volumeUp = "${pkgs.pamixer}/bin/pamixer --increase 5";
  volumeDown = "${pkgs.pamixer}/bin/pamixer --decrease 5";
  volumeMute = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
  brightnessUp = "${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
  brightnessDown = "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
  playerPlayPause = "${pkgs.playerctl}/bin/playerctl play-pause";
  playerNext = "${pkgs.playerctl}/bin/playerctl next";
  playerPrevious = "${pkgs.playerctl}/bin/playerctl previous";

  # Screenshot tool (grimblast requires grim, slurp, wl-clipboard)
  screenshotArea = "${pkgs.grimblast}/bin/grimblast copy area"; # Copy area to clipboard
  screenshotFull = "${pkgs.grimblast}/bin/grimblast copy output"; # Copy full output to clipboard

in
{
  wayland.windowManager.hyprland.enable = true;
	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER"; # Use the Super key (Windows key)

		# See https://wiki.hyprland.org/Configuring/Variables/
		# See https://wiki.hyprland.org/Configuring/Keywords/

		# Execute binds (Launch apps, system actions)
		bind = [
			# System actions
			"CTRL SHIFT, T, exec, ${terminal}"         # Open terminal
			"$mod, D, exec, ${launcher}"               # Open application launcher (wofi)
			"$mod, W, exec, ${browser}"                # Open browser
			"$mod, E, exec, ${fileManager}"            # Open file manager (Nemo)
			"$mod, L, exec, ${locker}"                 # Lock the screen (hyprlock)
			"$mod, X, exec, ${powerMenu}"              # Open power menu (wlogout)
			", Print, exec, ${screenshotArea}"           # Screenshot area to clipboard (grimblast)
			"$mod, Print, exec, ${screenshotFull}"     # Screenshot full output to clipboard (grimblast)
			"$mod SHIFT, Q, exit,"                     # Exit Hyprland (log out)

			# Window management
			"$mod, Q, killactive,"                     # Close active window
			"$mod, F, fullscreen,"                     # Toggle fullscreen on active window
			"$mod, V, togglefloating,"                 # Toggle floating on active window
			"$mod, P, pseudo,"                         # Pseudo Tiling mode: Floating window still respects tiled positions
			"$mod SHIFT, S, togglesplit,"              # Toggle split direction (for dwindle layout)

			# Move focus with Mod + HJKL or Arrows
			"$mod, H, movefocus, l"
			"$mod, L, movefocus, r"
			"$mod, K, movefocus, u"
			"$mod, J, movefocus, d"
			"$mod, left, movefocus, l"
			"$mod, right, movefocus, r"
			"$mod, up, movefocus, u"
			"$mod, down, movefocus, d"

			# Move windows with Mod + Shift + HJKL or Arrows
			"$mod SHIFT, H, movewindow, l"
			"$mod SHIFT, L, movewindow, r"
			"$mod SHIFT, K, movewindow, u"
			"$mod SHIFT, J, movewindow, d"
			"$mod SHIFT, left, movewindow, l"
			"$mod SHIFT, right, movewindow, r"
			"$mod SHIFT, up, movewindow, u"
			"$mod SHIFT, down, movewindow, d"

			# Swap windows (in Master layout)
			# "$mod, S, swapwindow, main" # Example for master layout

			# Resize windows (using mouse or keyboard)
			# $mod+RClick and drag to resize floating/pseudotiled
			# For tiled: Mod + Ctrl + Arrows or HJKL
			"$mod CTRL, H, resizeactive, -10 0"
			"$mod CTRL, L, resizeactive, 10 0"
			"$mod CTRL, K, resizeactive, 0 -10"
			"$mod CTRL, J, resizeactive, 0 10"
			"$mod CTRL, left, resizeactive, -10 0"
			"$mod CTRL, right, resizeactive, 10 0"
			"$mod CTRL, up, resizeactive, 0 -10"
			"$mod CTRL, down, resizeactive, 0 10"

			# Workspace management (already had this, enhanced)
			# binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
			# Note: code:1xx maps to physical keys 1-0, not numpad.
		]
			++ (builtins.concatLists (builtins.genList (i:
					let
						ws = i + 1;
						key = if i == 9 then "0" else toString ws; # Map 1-9 to 1-9, and 0 to 10
					in [
						"$mod, code:1${toString i}, workspace, ${toString ws}"
						"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
					]
				)
				10)) # Generate for 10 workspaces (keys 1-0)
			++ [
				# Switch to previous/next workspace
				"$mod, backslash, workspace, last" # Go to the last active workspace
				"$mod, C, workspace, empty"        # Go to next empty workspace (useful)

				# Move between monitors (if you have multiple displays)
				"$mod, comma, workspace, -1" # Go to previous workspace on the current monitor
				"$mod, period, workspace, +1" # Go to next workspace on the current monitor

				"$mod SHIFT, comma, movetoworkspace, -1" # Move active window to prev workspace on current monitor
				"$mod SHIFT, period, movetoworkspace, +1" # Move active window to next workspace on current monitor

				# Move active workspace to a specific monitor (0 is primary, 1 is secondary, etc.)
				# You might need to adjust monitor indices based on your setup (check hyprctl monitors)
				"$mod CTRL, right, movecurrentworkspacetomonitor, +1" # Move workspace to next monitor
				"$mod CTRL, left, movecurrentworkspacetomonitor, -1" # Move workspace to previous monitor
				# "$mod CTRL, 1, movecurrentworkspacetomonitor, 0" # Move workspace to monitor 0
				# "$mod CTRL, 2, movecurrentworkspacetomonitor, 1" # Move workspace to monitor 1
			]
			++ [
				# Special key binds (volume, brightness, media)
				# Use XF86 keys common on keyboards
				", XF86AudioRaiseVolume, exec, ${volumeUp}"
				", XF86AudioLowerVolume, exec, ${volumeDown}"
				", XF86AudioMute, exec, ${volumeMute}"
				", XF86AudioPlay, exec, ${playerPlayPause}"
				", XF86AudioPause, exec, ${playerPlayPause}" # Often the same key
				", XF86AudioNext, exec, ${playerNext}"
				", XF86AudioPrev, exec, ${playerPrevious}"
				", XF86MonBrightnessUp, exec, ${brightnessUp}"
				", XF86MonBrightnessDown, exec, ${brightnessDown}"
			];

		# Mouse binds (optional but common)
		bindm = [
			"$mod, mouse:272, movewindow" # Left click and drag to move floating windows
			"$mod, mouse:273, resizewindow" # Right click and drag to resize floating windows
		];

		# Window rules (optional, examples)
		# See https://wiki.hyprland.org/Configuring/Window-Rules/
		windowrulev2 = [

		];

		env = [
			"XCURSOR_SIZE,24" # Set cursor size
			"QT_QPA_PLATFORM,wayland" # Use Wayland backend for Qt
			"QT_ACCESSIBILITY,0"
			"QT_WAYLAND_DISABLE_WINDOWDECORATION,1" # Disable CSD for Qt apps (Hyprland provides SSD)
			"XDG_CURRENT_DESKTOP,Hyprland" # Report desktop environment
			"XDG_SESSION_TYPE,wayland"
			"XDG_SESSION_DESKTOP,Hyprland"
			"GDK_BACKEND,wayland,x11" # Prefer Wayland backend for GTK
			"CLUTTER_BACKEND,wayland" # Prefer Wayland backend for Clutter
		];

		# Animations (Hyprland has many, default set is good but customizable)
		# See https://wiki.hyprland.org/Configuring/Animations/
		animations = {
			enabled = true;
		};

		exec-once = [
			"waybar" # Start Waybar
			"nm-applet --indicator" # NetworkManager tray icon (if using NM)
			"blueman-applet" # Blueman tray icon (if using Bluetooth)
			"dunst" # Notification daemon (install pkgs.dunst)
			"udiskie --tray" # Disk automounting/tray icon (install pkgs.udiskie)
			"${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1" # PolicyKit agent for graphical prompts
			# Add your preferred wallpaper setter here, e.g.,
			# "${pkgs.swaybg}/bin/swaybg -m fill -i /path/to/your/wallpaper.jpg" # (install pkgs.swaybg)
		];
	};
}
