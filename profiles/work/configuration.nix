{ pkgs, lib, systemSettings, userSettings, ...}:
{
  imports = 
    [
      ../../hosts/${systemSettings.hostname}/hardware-configuration.nix
      ../../modules/nixos/sway.nix
      ../../modules/nixos/docker.nix
      ../../modules/nixos/spotifyd.nix
      ../../modules/nixos/thunar.nix
      ../../modules/nixos/obsidian.nix
      ../../modules/nixos/sh.nix
      ../../modules/nixos/1password.nix

    ];
# Shell
  # environment.shells = with pkgs; [ zsh ];
  # users.defaultUserShell = pkgs.zsh;
  # programs.zsh.enable = true;
# Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "se";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };



  # Networking
  #networking.hostName = systemSettings.hostname; # Define your hostname.
  networking.hostName = "e18m-ws"; # Define your hostname.
  networking.networkmanager.enable = true; # Use networkmanager
  networking.networkmanager.wifi.backend = "iwd";

  # Time zone and locale.
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.defaultLocale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.extraLocale;
    LC_IDENTIFICATION = systemSettings.extraLocale;
    LC_MEASUREMENT = systemSettings.extraLocale;
    LC_MONETARY = systemSettings.extraLocale;
    LC_NAME = systemSettings.extraLocale;
    LC_NUMERIC = systemSettings.extraLocale;
    LC_PAPER = systemSettings.extraLocale;
    LC_TELEPHONE = systemSettings.extraLocale;
    LC_TIME = systemSettings.extraLocale;
  };

  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
    uid = 1000;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    zsh
    git
    wget
    home-manager
    nodejs_20
    php
    gcc
    wlay
    nwg-look
    # swayfx
 mako
    swaylock-effects

  ];

  # Shell
  programs.neovim = {
    enable = true;
    vimAlias = true;

    configure = {
      vam.knownPlugins = pkgs.vimPlugins;
      vam.pluginsDictionaries = let
        names = [
        "fzf-vim"
        "fxfWrapper"
        ];
      in map (name: {inherit name;}) names;
    };
  };
  # Leave as is for compatibility purposes
  system.stateVersion = "23.11"; # Did you read the comment?
}
