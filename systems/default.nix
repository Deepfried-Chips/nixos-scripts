{self, ...}: let
  inherit (self) inputs;

  inherit (inputs) nixpkgs lanzaboote sops-nix;
  inherit (inputs.home-manager.nixosModules) home-manager;

  inherit (nixpkgs) lib;
  mkSystem = lib.nixosSystem;

  homeKelpforest = ../homes/Kelpforest;
  homeMushroomforest = ../homes/Mushroomforest;

  commonArgs = {inherit self inputs;};
in {
  "Kelpforest" = mkSystem {
    specialArgs = commonArgs;
    modules = [
      ./Kelpforest/configuration.nix

      home-manager
      homeKelpforest
      lanzaboote.nixosModules.lanzaboote
      sops-nix.nixosModules.sops
    ];
  };

  "Mushroomforest" = mkSystem {
    specialArgs = commonArgs;
    modules = [
      ./Mushroomforest/configuration.nix

      home-manager
      homeMushroomforest
      lanzaboote.nixosModules.lanzaboote
      sops-nix.nixosModules.sops
    ];
  };
}
