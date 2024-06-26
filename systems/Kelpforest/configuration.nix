# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix
    ../shared/docker.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = ["quiet" "udev.log_level=3"];
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Kelpforest"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  sops.defaultSopsFile = ../../secrets/chips.yaml;
  sops.age.keyFile = "/home/chips/.config/sops/age/keys.txt";
  sops.secrets."passwords/users/chips" = {};
  sops.secrets."passwords/users/chips".neededForUsers = true;

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false; # Unused in this case, just in case I need to enable it tho

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  users.users.chips = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."passwords/users/chips".path;
    description = "Deepfried Chips";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      discord
      signal-desktop
    ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
