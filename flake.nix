{
    description = "csman964 NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        disko = {
            url = "github:nix-community/disko";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, disko }: {
        nixosConfigurations = {
            t14 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    username = "csman";
                    hostname = "t14";
                    pkgs-unstable = import nixpkgs-unstable {
                        system = "x86_64-linux";
                        config.allowUnfree = true;
                    };
            };
            modules = [
                ./hosts/t14/configuration.nix
                ./hosts/t14/disko.nix
                disko.nixosModules.disko
                ./modules/core
                ./modules/desktop
                ./modules/home

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";
                    home-manager.extraSpecialArgs = {
                    username = "csman";
                    };
                    home-manager.users.csman = import ./modules/home/home.nix;
                }
            ];
            };
        };
    };

}