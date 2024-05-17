{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../common/brave.nix
    ../../common/git-base.nix
    ../../common/chips-git.nix
  ];

  home = {
    username = "chips";
    homeDirectory = "/home/chips";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
