{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Fonts
    #(nerdfonts.override { fonts = [ "Inconsolata" ]; })
    powerline
    inconsolata
    inconsolata-nerdfont
    font-awesome
    ubuntu_font_family
    terminus_font
    jetbrains-mono
    nerdfonts
  ];
}
