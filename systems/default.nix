{self, ...}: let
  inherit (self) inputs;

  inherit (inputs) nixpkgs lanzaboote;
  inherit (inputs.home-manager.nixosModules) home-manager;

  inherit (nixpkgs) lib;
  mkSystem = lib.nixosSystem;

  homeKelpforest = ../homes/Kelpforest;

  commonArgs = {inherit self inputs;};
in {
  "Kelpforest" = mkSystem {
    specialArgs = commmonArgs;
    modules = [
      ./Kelpforest/configuration.nix

      home-manager
      homeKelpforest
      lanzaboote.nixOsModules.lanzaboote
    ];
  };
}
