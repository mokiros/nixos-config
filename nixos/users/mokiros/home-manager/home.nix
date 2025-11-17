{
  pkgs,
  ...
}:

{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  imports = [
    ./packages.nix
    ./shells.nix
    ./git.nix
    ./vscode.nix
    ./spotify.nix
  ];

  home.username = "mokiros";
  home.homeDirectory = "/home/mokiros";

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "${pkgs.micro}/bin/micro";
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
