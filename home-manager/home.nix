{ inputs, lib, config, pkgs, ... }:

{
	home.stateVersion = "24.05";
	imports = [
		./packages.nix
		./desktop.nix
	];

	home.username = "mokiros";
	home.homeDirectory = "/home/mokiros";

	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		EDITOR = "${pkgs.micro}/bin/micro";
	};

	home.file.".xinitrc".text = ''
if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval $(dbus-launch --exit-with-session --sh-syntax)
fi
systemctl --user import-environment DISPLAY XAUTHORITY

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

exec awesome
	'';

	programs.zsh.enable = true;
	programs.starship.enable = true;
	programs.home-manager.enable = true;

	programs.git = {
		enable = true;
		userName = "mokiros";
		userEmail = "mokiros@yandex.ru";
		signing = {
			key = "20D623B706CF061C!";
			signByDefault = true;
		};
	};

	programs.gpg.enable = true;

	services.gpg-agent = {
		enable = true;
		defaultCacheTtl = 1800;
		enableSshSupport = true;
	};
}
