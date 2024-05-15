{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };

  services.flatpak.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };

  environment.systemPackages = with pkgs; [
    bluez-alsa
    bluez
    dbus
    mesa
    wget
    wl-clipboard
    xdg-utils
    firefox
    # brave # will add back properly later
    sbctl
    git
    pass
    github-cli
    git-credential-manager
    libsForQt5.plasma-browser-integration
    glxinfo
    clinfo
    vulkan-tools
    age # security jumbo
    sops
  ];

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    #nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    serif = ["Noto Serif"];
    sansSerif = ["Noto Sans"];
  };

  boot.plymouth.enable = true;

  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.acpid.enable = true;
  services.dbus.enable = true;
  services.lvm.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    jack.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = false;
    };
  };

  services.desktopManager.plasma6.enable = true;

  security.polkit.enable = true;
  security.rtkit.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  networking.networkmanager.enable = true;

  boot.supportedFilesystems = ["exfat" "vfat" "ntfs" "ext" "btrfs" "xfs"];

  console.useXkbConfig = true;

  users.defaultUserShell = pkgs.bash;

  system.stateVersion = "24.05";
}
