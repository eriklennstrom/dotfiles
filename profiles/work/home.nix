{ config, pkgs, userSettings, ... }:
{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;
  
  imports = [
    ../../modules/home/chromium.nix
    #../../modules/home/firefox.nix
    ../../modules/home/nvim.nix
    ../../modules/home/hyprpaper.nix
    ../../modules/home/kanshi.nix
    # ../../modules/home/hyprlock.nix
    ../../modules/home/swayosd.nix
    #../../modules/home/hyprlock.nix
    #../../modules/home/direnv.nix
    #../../modules/home/flameshot.nix
    #../../modules/home/golang.nix
    #../../modules/home/eww/eww.nix
    ../../modules/home/git.nix
    ##../../modules/home/notifications.nix // Using sway notifications instead, in sway.nix
    ../../modules/home/rofi/default.nix
    #../../modules/home/swayosd.nix
     ../../modules/home/theme.nix
    ../../modules/home/waybar.nix
    ../../modules/home/terminal.nix
    ../../modules/home/tmux.nix
    #../../modules/home/spotify.nix
    ##../../user/cli-collection.nix
  ];
  home.packages = with pkgs; [
    wl-clipboard
    vlc
    slack
    beekeeper-studio
    drm_info
    wev
    pavucontrol
  ];
  programs.hyprlock = { 
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "/home/e18m/Pictures/wallpapers/Rancho.png";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          # placeholder_text = '\<span foreground="##cad3f5">Password...</span>\';
          shadow_passes = 2;
        }
      ];
    };
  };



  home.file.".config" = {
    source = ../../configs;
    recursive = true;
  };
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = "exec " + userSettings.term + " -e " + userSettings.editor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  home.stateVersion = "23.11"; # Please read the comment before changing.
}
