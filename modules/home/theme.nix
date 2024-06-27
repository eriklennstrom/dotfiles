{ pkgs, ... }: {
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
  gtk = {
    enable = true;
    cursorTheme = {
      # package = pkgs.catppuccin-cursors.mochaSapphire;
      # name = "catppuccin-mocha-mauve-cursors";
      size = 48;
    };
    # catppuccin = {
    #   enable = true;
    #   cursor = {
    #     enable = true;
    #     flavor = "mocha";
    #     accent = "sapphire";
    #   };
    # };
  };
  home.pointerCursor = {
    # x11.enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaSapphire;
    name = "Catppuccin-Mocha-Mauve-Cursors";
    size = 22;
  };
}
