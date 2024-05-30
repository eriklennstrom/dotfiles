{ pkgs, lib, config, inputs, userSettings, ... }:
{
  imports = [
    ./sway.nix
    ./fonts.nix
  ];
  config = {
    home-manager.users.${userSettings.username} = 
    { pkgs, ... }:
    {
      home.sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        NIXOS_OZONE_WL = "1";
      };

      home.packages = with pkgs; [
        qt5.wayland
          qt6.wayland

          drm_info

          oculante
          grim
          slurp
          way-displays
          wl-clipboard
          wlay
          wev
          wtype
          inputs.nixpkgs-wayland.outputs.packages.${pkgs.stdenv.hostPlatform.system}.wl-gammarelay-rs
      ];
    };
  };
}