{ pkgs, lib, config, inputs, userSettings, ... }:
{
  imports = [
    # ./sway.nix
    ./fonts.nix
  ];
  config = {
    home-manager.users.${userSettings.username} = 
    { pkgs, ... }:
    {
      home.stateVersion = "23.11";
      home.sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        NIXOS_OZONE_WL = "1";
      };
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome.gnome-themes-extra;
        };
      };
      systemd.user.sessionVariables = config.home-manager.users.${userSettings.username}.home.sessionVariables;


      home.packages = with pkgs; [
        # qt5.wayland
          # qt6.wayland
          drm_info
          oculante
          grim
          slurp
          way-displays
          wl-clipboard
          wlay
          wev
          wtype
          # inputs.nixpkgs-wayland.outputs.packages.${pkgs.stdenv.hostPlatform.system}.wl-gammarelay-rs
      ];
    };
    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
