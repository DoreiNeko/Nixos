{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/gnome.nix
      ../../modules/nixos/main-user.nix
      ../../modules/nixos/asus.nix
      ../../modules/nixos/amd-drivers.nix
      ../../modules/nixos/pipewire.nix
      ../../modules/nixos/ollama.nix
    ];

  main-user.enable = true;
  main-user.userName = "dorei";

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Kernel options
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ 
    "quiet"
    "splash"
    "loglevel=3"
    "systemd.show_status=audo"
    "rd.udev.log_level=3"

    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth = {
    enable = true;
    theme = "spinner";
  };

  # Zram settings
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Network options
  networking.hostName = "asus-tuf"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #  Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # flatpak
  services.flatpak.enable = true;

  # Shell
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "24.05"; # Did you read the comment?
}
