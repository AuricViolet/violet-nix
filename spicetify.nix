{ config, pkgs, inputs, spicetify-nix, lib, chaotic, nix-gaming, ... }:

{
 # ─────────────────────────────────────────────────────────────────────────
  # 🧁 Spicetify
  # ─────────────────────────────────────────────────────────────────────────
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
      marketplace
    ];
    enabledSnippets = with spicePkgs.snippets; [ pointer ];
    #theme = spicePkgs.themes.catppuccin;
    #colorScheme = "mocha";
  };
}
