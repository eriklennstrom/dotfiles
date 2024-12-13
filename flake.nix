{
  description = "e18m flake config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, catppuccin, rose-pine-hyprcursor, home-manager, spicetify-nix, nixos-hardware, ... } @inputs:
    let
# --- SYSTEM SETTINGS --- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "e18m-x1";
      profile = "work";
      timezone = "Europe/Stockholm";
      defaultLocale = "en_US.UTF-8";
      extraLocale = "sv_SE.UTF-8";
    };

# --- USER SETTINGS --- #
    userSettings = rec {
      username = "e18m";
      name = "Erik";
      email = "erik@tedfeltlennstrom.se";
      dotfilesDir = "~/.dotfiles";
      wm = "sway";
      browser = "chromium";
      editor = "nvim";
      term = "kitty";
      font = "D2CodingLigature Nerd Font";
      fontPkg = pkgs.fira-code-nerdfont;
      };


    lib = nixpkgs.lib;
    pkgs = import nixpkgs { 
      system = systemSettings.system; 
      config = { 
          allowUnfree = true; 
        };
      };
    in {
      nixosConfigurations = {
        e18m-x1 = lib.nixosSystem {
          modules = [
            (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix") 
            nixos-hardware.nixosModules.framework-intel-core-ultra-series1
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = import (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix"); 
              home-manager.extraSpecialArgs = {
                inherit userSettings;
                inherit systemSettings;       
                inherit spicetify-nix;
              };

            }
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-12th-gen
          ];
        specialArgs = {
          inherit inputs;
          inherit userSettings;
          inherit systemSettings;
        };
      };
    };
  };
}
