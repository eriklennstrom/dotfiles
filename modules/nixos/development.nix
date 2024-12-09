{ pkgs, userSettings, ...}:
{
  environment.systemPackages = with pkgs; [
    go
    nodejs_20
    chromedriver
    php
    php82Packages.composer
    phpactor
    laravel
    gnumake
    lazydocker
  ];
  ### MariaDB
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;
  services.longview.mysqlPasswordFile = "/run/keys/mysql.password";

  ### Docker
  virtualisation.docker.enable = true;
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
}
