{ config, lib, pkgs, modulesPath, ... }:
{
  services.libinput = {
    enable = true;
    touchpad = {
      tapping = true;
      naturalScrolling = false;
    };
  };
}
