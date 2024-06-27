{ config, pkgs, lib, ... }:
{
  imports = [ 
    ./fonts.nix
  ];

  environment.systemPackages = with pkgs;
  [
    # mako
    swaylock-effects
    swaysettings
    swaynotificationcenter
  ];

  services.gnome.gnome-keyring.enable = true;
  #
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export WLR_NO_HARDWARE_CURSORS=1
    '';
  };
    #xdg.configFile."sway/config".source = ../../configs/sway/config;
  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "se";
      variant = "";
      #options = "caps:escape";
    };
  };
}
