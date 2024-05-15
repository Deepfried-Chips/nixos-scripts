{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../common/visualstudio.nix
    ../../common/git-base.nix
  ];

  home = {
    username = "chips";
    homeDirectory = "/home/chips";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
