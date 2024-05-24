{
  description = "e18m flake config";
  outputs = { self, nixpkgs, home-manager, ... }:
    let
# --- SYSTEM SETTINGS --- #
    systemSettings = {
      system = "x86_64-linux";
      hostname = "e18m-xps";
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
    font = "FiraCode Nerd Font";
    fontPkg = pkgs.fira-code-nerdfont;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOs/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
# pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  # lib = nixpkgs.lib.extend (final: prev: {
  #   my = import ./lib {
  #     inherit pkgs inputs;
  #     lib = final;
  #   };
  # });
  lib = nixpkgs.lib;
  pkgs = import nixpkgs { 
    system = systemSettings.system; 
    config = { 
      allowUnfree = true; 
    };
  };
  # lib = import ./lib { inherit pkgs inputs; lib = nixpkgs.lib; };
  # inherit (lib._) mapModules mapModulesRec mkHost;
  in {
    nixosConfigurations = {
      e18m-xps = lib.nixosSystem {
        modules = [
          <nixos-hardware/dell/xps/13-9310>
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix") 
        ];
        specialArgs = {
          inherit userSettings;
          inherit systemSettings;
        };
      };
      e18m-ws = lib.nixosSystem {
        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix") 
        ];
        specialArgs = {
          inherit userSettings;
          inherit systemSettings;
        };
      };
    };
    homeConfigurations = {
      e18m = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") 
        ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit systemSettings;       
        };
      };
    };
  };
}
