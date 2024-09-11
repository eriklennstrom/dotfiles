{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Fonts
    #(nerdfonts.override { fonts = [ "Inconsolata" ]; })
    powerline
    inconsolata
    inconsolata-nerdfont
    font-awesome
    feather
    ubuntu_font_family
    terminus_font
    jetbrains-mono
    nerdfonts
    fira-code-nerdfont
  ];
}
