{ pkgs, userSettings, ... }:
{
  # catppuccin = {
  #   enable = true;
  #   flavor = "mocha";
  # };
  # home.pointerCursor = {
    # gtk.enable = true;
    # package = pkgs.catppuccin-cursors.mochaMauve;
    # name = "Catppuccin-Mocha-Mauve-Cursors";
    # size = 22;
  # };
  gtk = {
    enable = true;

    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "whitesur-gtk";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
  # home-manager.users.${userSettings.username} = {
  #   gtk = {
  #     enable = true;
  #     theme = {
  #       name = "Adwaita-dark";
  #       package = pkgs.gnome.gnome-themes-extra;
  #     };
  #   };
  #   # Wayland, X, etc. support for session vars
  #   systemd.user.sessionVariables = config.home-manager.users.${userSettings.username}.home.sessionVariables;
  # };
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };
}
