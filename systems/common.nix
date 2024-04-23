{inputs, config, pkgs, lib, ...}: {
    services.xserver = {
        enable = true;
        xkb.layout = "us";
    };

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    programs.zsh.enable = true;

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
    ];

    fonts.packages = with pkgs; [
        font-awesome
        jetbrains-mono
        nerdfonts
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
    services.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

        jack.enable = true;
    };

    security.polkit.enable = true;

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

    networking.networkmanager.enable = true;

    boot.supportedFilesystems = ["exfat" "vfat" "ntfs" "ext" "btrfs" "xfs"];

    console.useXkbConfig = true;

    users.defaultUserShell = pkgs.zsh;

    system.stateVersion = "24.05";
}
