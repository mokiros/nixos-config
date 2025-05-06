{ inputs, lib, config, pkgs, ...}:

{
	nixpkgs = {
		overlays = [];
		config = {
			allowUnfree = true;
		};
	};

	# This will add each flake input as a registry
	# To make nix3 commands consistent with your flake
	nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

	# This will additionally add your inputs to the system's legacy channels
	# Making legacy nix commands consistent as well, awesome!
	nix.nixPath = ["/etc/nix/path"];
	environment.etc =
		lib.mapAttrs'
		(name: value: {
			name = "nix/path/${name}";
			value.source = value.flake;
		})
		config.nix.registry;

	nix.settings = {
		experimental-features = "nix-command flakes";
		auto-optimise-store = true;
	};
	nix.gc.automatic = true;

	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [ vim micro wget htop ];

	time.timeZone = "Europe/Minsk";
	i18n.defaultLocale = "en_US.UTF-8";

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		wireplumber.enable = true;
	};

	users.users = {
		mokiros = {
			initialPassword = "123";
			isNormalUser = true;
			extraGroups = [ "wheel" ];
			shell = pkgs.zsh;
		};
	};
}
