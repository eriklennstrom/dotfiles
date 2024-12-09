{ pkgs, lib, userSettings, ... }:
{
  environment.systemPackages = with pkgs;
  [
    obsidian
  ];
}
