{ config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [ rofi-emoji rofi-calc ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 16px";
      display-drun = "Applications";
      drun-display-format = "{name}";
      cycle = false;
    };
    # theme = ./index.rasi;
  };
  # xdg.configFile."rofi/index.rasi".source = ./index.rasi;
  # xdg.configFile."rofi/power.rasi".source = ./power.rasi;
  # xdg.configFile."rofi/calc.rasi".source = ./calc.rasi;
  #xdg.configFile."rofi/light.rasi".text = let t = my.palette;

}
