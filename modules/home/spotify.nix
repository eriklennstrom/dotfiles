{ pkgs, lib, spicetify-nix, inputs, ... }:
{
# import the flake's module for your system
  # imports = [ spicetify-nix.homeManagerModules ];

# configure spicetify :)
  programs.spicetify =
# let
#   betterBloom = pkgs.fetchgit {
#     url = "https://github.com/sanoojes/better-bloom";
#     sha256 = "qgbn0imyridkb9527v6gnv6z3jzzprb9";
#   };
# in 
  let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.dribbblish;
    colorScheme = "Rosé Pine";
    #
    enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
        powerBar
        adblock
    ];
  };
}
