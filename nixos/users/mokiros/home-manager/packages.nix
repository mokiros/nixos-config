{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    btop
    fastfetch

    pamixer
    pavucontrol
    networkmanagerapplet
    blueman
    udiskie

    vesktop

    wayvnc

    nerd-fonts.fira-code

    fzf
    grc

    (prismlauncher.override {
      additionalPrograms = [ ];

      jdks = [
        graalvmPackages.graalvm-ce
        zulu8
        zulu17
        zulu
        jdk21
        jdk17
        jdk8
      ];
    })
  ];
}
