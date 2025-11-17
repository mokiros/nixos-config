{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  # home.packages = with pkgs; [
  #   # spotify
  # ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        history
        betterGenres
        volumePercentage
        skipAfterTimestamp
        addToQueueTop
        bookmark
        fullAlbumDate
        songStats
        showQueueDuration
        playingSource
        sectionMarker
        queueTime
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
        marketplace
      ];
      enabledSnippets = with spicePkgs.snippets; [
        pointer
      ];

      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
}
