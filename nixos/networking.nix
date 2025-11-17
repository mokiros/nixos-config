{
  pkgs,
  ...
}:
{
  services.dnscrypt-proxy = {
    enable = true;

    settings = {
      listen_addresses = [
        "127.0.0.1:53"
        "[::1]:53"
      ];
      server_names = [ "NextDNS-fb8444" ];

      static = {
        NextDNS-fb8444 = {
          stamp = "sdns://AgEAAAAAAAAAAAAOZG5zLm5leHRkbnMuaW8HL2ZiODQ0NA";
        };
      };

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
    };
  };

  networking.nameservers = [
    "127.0.0.1"
    "::1"
  ];

  networking.resolvconf.enable = false;
  services.resolved.enable = false;

  environment.systemPackages = with pkgs; [
    networkmanager-openvpn
  ];

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.networkmanager.plugins = [
    pkgs.networkmanager-openvpn
  ];
}
