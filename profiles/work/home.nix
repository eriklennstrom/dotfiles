{ config, pkgs, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;
  
  imports = [
    ../../modules/home/chromium.nix
    ../../modules/home/nvim.nix
    ../../modules/home/direnv.nix
    ../../modules/home/flameshot.nix
    ../../modules/home/golang.nix
    #../../modules/home/fzf.nix
    ../../modules/home/git.nix
    #../../modules/home/notifications.nix // Using sway notifications instead, in sway.nix
    ../../modules/home/rofi/default.nix
    ../../modules/home/theme.nix
    ../../modules/home/waybar.nix
    ../../modules/home/terminal.nix
    #../../user/cli-collection.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  ## Copy dotfiles to .config
  home.file.".config" = {
    source = ../../configs;
    recursive = true;
  };
  services.swayidle = { 
    enable = true;
  };


  home.packages = (with pkgs; [
    # Core
      wget
      spotify-player

      vlc
      slack
      beekeeper-studio
      drm_info

      oculante
      grim
      slurp
      wl-clipboard
      wlay
      wev
      wtype
      pavucontrol
  ]);

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = "exec " + userSettings.term + " -e " + userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };
 }
