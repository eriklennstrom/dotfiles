{ pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload =
        [ "/home/e18m/Pictures/wallpapers/Rancho.png" ];

      wallpaper = [
        ",/home/e18m/Pictures/wallpapers/Rancho.png"
      ];
    };
  };
}
