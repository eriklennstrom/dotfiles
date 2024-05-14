{ pkgs, userSettings, ... }:
{
  services.spotifyd.enable = true;
  # environment.systemPackages = [
  #   pkgs.spotifyd
  # ];
}
