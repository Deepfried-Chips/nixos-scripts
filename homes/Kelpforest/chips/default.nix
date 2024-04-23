{pkgs, lib, inputs, ...}: {
    imports = [
    ];

    home = {
        username = "chips";
        homeDirectory = "/home/chips";
    };

    programs.home-manager.enable = true;

    home.stateVersion = "24.05";
}
