{ pkgs, ... }:
{
  home.packages = with pkgs; [ libnotify ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 320;
        height = 80;
        origin = "top-right";
      };
    };
  };
}
