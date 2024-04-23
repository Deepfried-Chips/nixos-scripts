{inputs, self, config, ...}: {
    home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {
            inherit inputs self;
        };
        users = {
            chips = ./chips;
        };
    };
}
