# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, systemSettings, userSettings, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../hosts/${systemSettings.hostname}/default.nix
      ../../modules/nixos/shell.nix
      ../../modules/nixos/obsidian.nix
      ../../modules/nixos/hyprland.nix
      ../../modules/nixos/cursor.nix
      ../../modules/nixos/development.nix
      ../../modules/nixos/fonts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.libinput.enable = true;

  # multi-touch gesture recognizer
  services.touchegg.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Fwupd, firmware updater
  services.fwupd.enable = true;

  services.flatpak.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "e18m-x1c"; # Define your hostname.
  networking.wireless.iwd = {
    enable = true;
  };
  #
  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.displayManager.gdm.wayland.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };
 hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Configure console keymap
  console.keyMap = "sv-latin1";
  # security.polkit.enable = true;
  security.pam.services.hyprlock = {};
  # Enable CUPS to print documents.
  services.printing.enable = true;  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.power-profiles-daemon.enable = false;
  powerManagement.enable = true;

  boot.extraModprobeConfig = ''
    options hid_apple swap_fn_leftctrl=1
    options hid_apple swap_opt_cmd=1
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # User account
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [  "wheel" ];
    packages = [];
    uid = 1000;
  };
  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    fzf
    gnumake
    vim
    wget
    git
    gcc                   # Required for some plugins in NVIM
    nautilus              # File GUI
    wlay                  # Monitor orientation
    wdisplays             # Same as WLAY
    nwg-look
    overskride            #bluetooth
    # iwgtk                 #wlan gui
    spotify
    # networkmanagerapplet
    caligula
    corectrl
    glxinfo
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
