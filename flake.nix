{
	description = "mokiros's nixos flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		hyprland.url = "github:hyprwm/Hyprland";

		hardware.url = "github:nixos/nixos-hardware";
	};

	outputs = { self, nixpkgs, home-manager, ... } @ inputs:
		let inherit (self) outputs;
		in {
			nixosConfigurations = {
				lenovo-nixos = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs outputs; };
					modules = [
						./nixos/lenovo/configuration.nix

						# home manager integrated with system because I want it that way
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.mokiros = import ./home-manager/home.nix;
						}
					];
				};
				qemu-nixos = nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs outputs; };
					modules = [
						./nixos/qemu/configuration.nix

						# home manager integrated with system because I want it that way
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.mokiros = import ./home-manager/home.nix;
						}
					];
				};
			};
		};
}
