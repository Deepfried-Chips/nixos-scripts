# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = ["quiet" "udev.log_level=3"];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  sops.defaultSopsFile = ../../secrets/chips.yaml;
  sops.age.keyFile = "/home/chips/.config/sops/age/keys.txt";
  sops.secrets."passwords/users/chips" = {};
  sops.secrets."passwords/users/chips".neededForUsers = true;

  virtualisation.waydroid.enable = true;
  networking.hostName = "Mushroomforest"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  programs.partition-manager.enable = true;

  security.apparmor.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.config.common.default = "gtk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chips = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."passwords/users/chips".path;
    description = "Deepfried Chips";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      discord
      btop
      signal-desktop
    ];
  };

  #services.openssh.enable = true;
}
