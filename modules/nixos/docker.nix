{ pkgs, userSettings, ... }:
{
  virtualisation.docker.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
