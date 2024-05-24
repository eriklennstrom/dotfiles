{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.whitesur-gtk-theme;
      name = "WhiteSur-dark";
    };
    iconTheme = {
      package = pkgs.whitesur-icon-theme;
      name = "WhiteSur";
    };
    font = {
      name = "SF Pro Text";
      size = 11;
    };
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
      size = 30;
    };
    # gtk3.extraConfig = {
    #   Settings = ''gtk-application-prefer-dark-theme=1'';
    # };
    # gtk4.extraConfig = {
    #   Settings = ''gtk-application-prefer-dark-theme=1'';
    # };
  };
}
