{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bind
    bash
    vim
    micro
    wget
    htop
    git
    gnupg
    pciutils

    firefox
    chromium

    wayvnc

    vlc
    mpv

    qbittorrent

    pkgs.nixfmt-rfc-style
    nixd

    gcc

    nodejs
    bun
    cargo
    rustc
  ];
}
